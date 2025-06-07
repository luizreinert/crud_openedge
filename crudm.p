/* Inclusão do arquivo contendo as TEMP-TABLES */
{crud.i}

// Inputs de produtos
DEFINE INPUT            PARAMETER       ipChOpcao             AS CHARACTER      NO-UNDO.
DEFINE INPUT            PARAMETER       ipIIdProduto          AS INTEGER        NO-UNDO.
DEFINE INPUT            PARAMETER       ipChNome              AS CHARACTER      NO-UNDO.
DEFINE INPUT            PARAMETER       ipChDescProd          AS CHARACTER      NO-UNDO.
DEFINE INPUT            PARAMETER       ipIQuantidade         AS INTEGER        NO-UNDO.
DEFINE INPUT            PARAMETER       ipDValor              AS DECIMAL        NO-UNDO.
DEFINE INPUT            PARAMETER       ipDtCadastro          AS DATE           NO-UNDO.
DEFINE INPUT            PARAMETER       ipChVendedor          AS CHARACTER      NO-UNDO.
DEFINE INPUT            PARAMETER       ipChNomeEmp           AS CHARACTER      NO-UNDO.
DEFINE INPUT            PARAMETER       ipLAtivo              AS LOGICAL        NO-UNDO.

// Inputs empresa 
DEFINE INPUT            PARAMETER       ipIEUnidadeEmp       AS INTEGER         NO-UNDO.
DEFINE INPUT            PARAMETER       ipChENomeEmp         AS CHARACTER       NO-UNDO.
DEFINE INPUT            PARAMETER       ipChCep              AS CHARACTER       NO-UNDO.
DEFINE INPUT            PARAMETER       ipChCnpj             AS CHARACTER       NO-UNDO.
DEFINE INPUT            PARAMETER       ipChEndereco         AS CHARACTER       NO-UNDO.
DEFINE INPUT            PARAMETER       ipChRazaoSocial      AS CHARACTER       NO-UNDO.

// Inputs vendedor 
DEFINE INPUT            PARAMETER       ipChLogin            AS CHARACTER       NO-UNDO.
DEFINE INPUT            PARAMETER       ipChVNome            AS CHARACTER       NO-UNDO.
DEFINE INPUT            PARAMETER       ipISetor             AS INTEGER         NO-UNDO.
DEFINE INPUT            PARAMETER       ipISecao             AS INTEGER         NO-UNDO.
DEFINE INPUT            PARAMETER       ipIUnidadeEmp        AS INTEGER         NO-UNDO.
DEFINE INPUT            PARAMETER       ipDSalario           AS DECIMAL         NO-UNDO.
DEFINE INPUT            PARAMETER       ipChEmail            AS CHARACTER       NO-UNDO.
DEFINE INPUT            PARAMETER       ipChTelefone         AS CHARACTER       NO-UNDO.

// Input-outputs para as temp-tables
DEFINE INPUT-OUTPUT     PARAMETER       TABLE FOR ttProduto.
DEFINE INPUT-OUTPUT     PARAMETER       TABLE FOR ttVendedor.
DEFINE INPUT-OUTPUT     PARAMETER       TABLE FOR ttEmpresa.


// Outputs de lógica/mensagem de erro
DEFINE OUTPUT           PARAMETER       opLErro              AS LOGICAL         NO-UNDO.
DEFINE OUTPUT           PARAMETER       opChMensagemErro     AS CHARACTER       NO-UNDO.


// Transfere os dados das planilhas para as temp-tables
PROCEDURE pVerificar:
  INPUT FROM planilhas/produto.csv.
    REPEAT: 
      IMPORT DELIMITER ";"
        ipIIdProduto
        ipChNome
        ipChDescProd
        ipIQuantidade
        ipDValor
        ipDtCadastro
        ipChVendedor
        ipChNomeEmp
        ipLAtivo.
      CREATE ttProduto.
      ASSIGN 
        ttProduto.iIdProduto    = ipIIdProduto
        ttProduto.chNome        = ipChNome
        ttProduto.chDescProd    = ipChDescProd
        ttProduto.iQuantidade  = ipIQuantidade
        ttProduto.dValor       = ipDValor
        ttProduto.dtCadastro   = ipDtCadastro
        ttProduto.chVendedor    = ipChVendedor
        ttProduto.chNomeEmp     = ipChNomeEmp
        ttProduto.lAtivo       = ipLAtivo NO-ERROR.
      END.
  INPUT CLOSE.
  INPUT FROM planilhas/vendedor.csv.
    REPEAT:
      IMPORT DELIMITER ";"
        ipChLogin
        ipChNome
        ipISetor
        ipISecao
        ipIUnidadeEmp
        ipDSalario
        ipChEmail
        ipChTelefone.
      CREATE ttVendedor.
    ASSIGN
        ttVendedor.chLogin      = ipChLogin
        ttVendedor.chNome       = ipChNome
        ttVendedor.iSetor       = ipISetor
        ttVendedor.iSecao       = ipISecao
        ttVendedor.iUnidadeEmp  = ipIUnidadeEmp
        ttVendedor.dSalario     = ipDSalario
        ttVendedor.chEmail      = ipChEmail
        ttVendedor.chTelefone   = ipChTelefone NO-ERROR.
      END.
  INPUT CLOSE.
  INPUT FROM planilhas/empresa.csv.
    REPEAT:
      IMPORT DELIMITER ";"
        ipIUnidadeEmp
        ipChENomeEmp
        ipChCep
        ipChCnpj
        ipChEndereco
        ipChRazaoSocial.
      CREATE ttEmpresa.
      ASSIGN 
        ttEmpresa.iUnidadeEmp    = ipiEUnidadeEmp
        ttEmpresa.chNomeEmp      = ipChENomeEmp
        ttEmpresa.chCep          = ipChCep
        ttEmpresa.chCnpj         = ipChCnpj
        ttEmpresa.chEndereco     = ipChEndereco
        ttEmpresa.chRazaoSocial  = ipChRazaoSocial NO-ERROR.
      END.
  INPUT CLOSE.    
END PROCEDURE.

// Valida a entrada dos dados, e se tudo estiver correto cria um novo produto.
PROCEDURE pCriarProduto:
    ASSIGN opLErro = TRUE.
        IF ipChNome = "" OR ipChDescProd = "" OR ipChVendedor = "" OR ipChNomeEmp = ""  THEN DO:
            ASSIGN opChMensagemErro = "Todos os campos devem ser preenchidos!".
            RETURN NO-APPLY.
        END.
        FIND ttProduto WHERE ttProduto.chNome = ipChNome NO-LOCK NO-ERROR.
            IF AVAILABLE ttProduto THEN DO:
                ASSIGN opChMensagemErro = "O produto " + ipChNome + " já foi cadastrado!".
                RETURN NO-APPLY.
        END.
        IF ipDValor < 0 OR ipIQuantidade < 0 THEN DO:
            ASSIGN opChMensagemErro = "O valor não pode ser negativo!".
            RETURN NO-APPLY.
        END.
        FIND FIRST ttVendedor WHERE ttVendedor.chNome = TRIM(ipChVendedor) NO-LOCK NO-ERROR.
        IF NOT AVAILABLE ttVendedor THEN DO:
            ASSIGN opChMensagemErro = "O vendedor " + ipChVendedor + " não foi encontrado!".
            RETURN.
        END.
        FIND FIRST ttEmpresa WHERE ttEmpresa.chNomeEmp = ipChNomeEmp NO-LOCK NO-ERROR.
            IF NOT AVAILABLE ttEmpresa THEN DO:
                ASSIGN opChMensagemErro = "A empresa " + ipChNomeEmp + " não foi encontrada!".
                RETURN.
        END.
        ELSE DO:
           DEFINE VAR iProxId  AS INTEGER INITIAL 1 NO-UNDO.
           FOR EACH ttProduto NO-LOCK.
            ASSIGN iProxId = iProxId + 1.
           END.
            CREATE ttProduto.
                ASSIGN 
                       ttProduto.iIdProduto = iProxId
                       ttProduto.chNome = CAPS(ipChNome)
                       ttProduto.chDescProd = CAPS(ipChDescProd)
                       ttProduto.iQuantidade = ipIQuantidade
                       ttProduto.dValor = ipDValor
                       ttProduto.dtCadastro = TODAY
                       ttProduto.chVendedor = CAPS(ipChVendedor)
                       ttProduto.chNomeEmp = CAPS(ipChNomeEmp)
                       ttProduto.lAtivo = ipLAtivo.
        END.       
    ASSIGN opLErro = FALSE.
END PROCEDURE.


// Deleta produtos.
PROCEDURE pDeletarProduto:
    FIND FIRST ttProduto EXCLUSIVE-LOCK
    WHERE ttProduto.iIdProduto = ipIIdProduto NO-ERROR. 
    IF AVAILABLE ttProduto THEN DO:
        DELETE ttProduto NO-ERROR. 
    END.  
    ELSE DO:
       ASSIGN opLErro = TRUE.
       ASSIGN opChMensagemErro = "Erro ao deletar produto.".
    END.     
END PROCEDURE.


// Valida a entrada dos dados, e se tudo estiver correto altera o produto selecionado no browse.
PROCEDURE pAlterarProduto:
  ASSIGN opLErro = TRUE.
        IF ipChNome = "" OR ipChDescProd = "" OR ipChVendedor = "" OR ipChNomeEmp = ""  THEN DO:
            ASSIGN opChMensagemErro = "Todos os campos devem ser preenchidos!".
            RETURN NO-APPLY.
        END.
        /*FIND ttProduto WHERE ttProduto.chNome = ipChNome NO-LOCK NO-ERROR.
            IF AVAILABLE ttProduto THEN DO:
                opChMensagemErro = "O produto " + ipChNome + " já foi cadastrado!".
                RETURN NO-APPLY.
        END.*/
        IF ipDValor < 0 OR ipIQuantidade < 0 THEN DO:
            ASSIGN opChMensagemErro = "O valor não pode ser negativo!".
            RETURN NO-APPLY.
        END.
        FIND ttEmpresa WHERE ttEmpresa.chNomeEmp = ipChNomeEmp NO-LOCK NO-ERROR.
            IF NOT AVAILABLE ttEmpresa THEN DO:
                ASSIGN opChMensagemErro = "A empresa " + ipChNomeEmp + " não foi encontrada!".
                RETURN.
        END.
        FIND ttVendedor WHERE ttVendedor.chNome = ipChVendedor NO-LOCK NO-ERROR.
        IF NOT AVAILABLE ttVendedor THEN DO:
            ASSIGN opChMensagemErro = "O vendedor " + ipChVendedor + " não foi encontrado!".
            RETURN.
        END.
        ELSE DO:
            FIND ttProduto EXCLUSIVE-LOCK WHERE ttProduto.iIdProduto = ipIIdProduto. 
            IF AVAILABLE ttProduto THEN DO:
              ASSIGN 
                       ttProduto.chNome = ipChNome
                       ttProduto.chDescProd = ipChDescProd
                       ttProduto.iQuantidade = ipIQuantidade
                       ttProduto.dValor = ipDValor
                       ttProduto.dtCadastro = TODAY
                       ttProduto.chVendedor = ipChVendedor
                       ttProduto.chNomeEmp = ipChNomeEmp
                       ttProduto.lAtivo = ipLAtivo NO-ERROR.  
            END.
     END.
     ASSIGN opLErro = FALSE.
END PROCEDURE.

// Gera o relatório dos produtos cadastrados.
PROCEDURE pGerarRelatorio:
    OUTPUT TO planilhas/relatorio.csv.
    EXPORT TODAY STRING(TIME,"HH:MM:SS").
    FOR EACH ttProduto NO-LOCK:
        FIND ttVendedor NO-LOCK
            WHERE ttVendedor.chNome     = ttProduto.chVendedor.
        FIND ttEmpresa  NO-LOCK
            WHERE ttEmpresa.chNomeEmp   = ttProduto.chNomeEmp.
        EXPORT DELIMITER ";"
            ttProduto.iIdProduto
            ttProduto.chNome
            ttProduto.chDescProd
            ttProduto.iQuantidade
            STRING(ttProduto.dValor, "R$>>>,>>9,99")
            ttProduto.dtCadastro
            STRING(ttProduto.lAtivo, "SIM/NAO")
            ttVendedor.chNome
            ttVendedor.chLogin
            ttVendedor.chEmail
            STRING(ttVendedor.chTelefone, "(XX) XXXXX-XXXX")
            STRING(ttVendedor.dSalario, "R$>>>,>>9,99")
            ttEmpresa.chNomeEmp
            ttEmpresa.chRazaoSocial
            STRING(ttEmpresa.chCnpj, "XX.XXX.XXX/XXXX-XX").
    END. 
    OUTPUT CLOSE.
END PROCEDURE.

CASE ipChOpcao:
    WHEN "Verificar" THEN DO:
        RUN pVerificar.
    END.
    WHEN "RELATORIO" THEN DO:
        RUN pGerarRelatorio.
    END.
    WHEN "ALTERAR" THEN DO:
        RUN pAlterarProduto.
    END.
    WHEN "CRIAR" THEN DO:
        RUN pCriarProduto.
    END.
    WHEN "DELETAR" THEN DO:
        RUN pDeletarProduto.
    END.
END CASE.