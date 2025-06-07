/* TREINAMENTO 4GL */

/* Inclusão do arquivo contendo as TEMP-TABLES */
{crud.i}

/* Variáveis produto */
DEFINE VARIABLE iIdProduto          AS INTEGER      FORMAT ">9"                             NO-UNDO.
DEFINE VARIABLE chNome              AS CHARACTER    FORMAT "X(15)"                          NO-UNDO.
DEFINE VARIABLE chDescProd          AS CHARACTER    FORMAT "X(15)"                          NO-UNDO.
DEFINE VARIABLE iQuantidade         AS INTEGER      FORMAT ">9"                             NO-UNDO.
DEFINE VARIABLE dValor              AS DECIMAL      FORMAT "R$->>>,>>9,99"                  NO-UNDO.
DEFINE VARIABLE dtCadastro          AS DATE         FORMAT "99/99/9999"                     NO-UNDO.
DEFINE VARIABLE chVendedor          AS CHARACTER    FORMAT "X(15)"                          NO-UNDO.
DEFINE VARIABLE chNomeEmp           AS CHARACTER    FORMAT "X(15)"                          NO-UNDO.
DEFINE VARIABLE lAtivo              AS LOGICAL      FORMAT "SIM/NAO"        INITIAL "SIM"   NO-UNDO.

/* Variaveis empresa */
DEFINE VARIABLE iEUnidadeEmp        AS INTEGER   FORMAT  ">999"                             NO-UNDO.
DEFINE VARIABLE chENomeEmp          AS CHARACTER FORMAT  "X(15)"                            NO-UNDO.
DEFINE VARIABLE chCep               AS CHARACTER FORMAT  "XXXXX-XXX"                        NO-UNDO.
DEFINE VARIABLE chCnpj              AS CHARACTER FORMAT  "XX.XXX.XXX/XXXX-XX"               NO-UNDO.
DEFINE VARIABLE chEndereco          AS CHARACTER FORMAT  "X(15)"                            NO-UNDO.
DEFINE VARIABLE chRazaoSocial       AS CHARACTER FORMAT  "X(15)"                            NO-UNDO.

/* Variaveis vendedores */
DEFINE VARIABLE chLogin             AS CHARACTER FORMAT "X(15)"                             NO-UNDO.
DEFINE VARIABLE chVNome             AS CHARACTER FORMAT "X(15)"                             NO-UNDO.
DEFINE VARIABLE iSetor              AS INTEGER   FORMAT ">999"                              NO-UNDO.
DEFINE VARIABLE iSecao              AS INTEGER   FORMAT ">999"                              NO-UNDO.
DEFINE VARIABLE iUnidadeEmp         AS INTEGER   FORMAT ">999"                              NO-UNDO.
DEFINE VARIABLE dSalario            AS DECIMAL   FORMAT "R$->>>,>>9,99"                     NO-UNDO.
DEFINE VARIABLE chEmail             AS CHARACTER FORMAT "X(15)"                             NO-UNDO.
DEFINE VARIABLE chTelefone          AS CHARACTER FORMAT "(XX)XXXXX-XXXX"                    NO-UNDO.


/* Definição de Botões e lógica */
DEFINE VARIABLE lErro               AS LOGICAL                                              NO-UNDO.
DEFINE VARIABLE chMensagemErro      AS CHARACTER                                            NO-UNDO.
DEFINE BUTTON btBuscar              LABEL "Buscar".
DEFINE BUTTON btNovo                LABEL "Novo".
DEFINE BUTTON btAlterar             LABEL "Alterar".
DEFINE BUTTON btDeletar             LABEL "Deletar".
DEFINE BUTTON btCancelar            LABEL "Cancelar".
DEFINE BUTTON btSalvar              LABEL "Salvar".
DEFINE BUTTON btCancelarCadastro    LABEL "Cancelar".
DEFINE BUTTON btGerarRelatorio      LABEL "Gerar Relatório".

/* Dados Iniciais para Teste */

/* Definição de Query e Browse */
DEFINE QUERY qrBrTTProduto FOR ttProduto SCROLLING.

DEFINE BROWSE brTTProduto
    QUERY qrBrTTProduto
    DISPLAY 
        ttProduto.iIdProduto        COLUMN-LABEL "ID"
        ttProduto.chNome            COLUMN-LABEL "NOME" 
        ttProduto.chDescProd        COLUMN-LABEL "DESCRICAO"
        ttProduto.iQuantidade       COLUMN-LABEL "QUANTIDADE"
        ttProduto.dValor            COLUMN-LABEL "VALOR"
        ttProduto.dtCadastro        COLUMN-LABEL "DATA CAD."
        ttProduto.chVendedor        COLUMN-LABEL "VENDEDOR"
        ttProduto.chNomeEmp         COLUMN-LABEL "EMPRESA"
        ttProduto.lAtivo            COLUMN-LABEL "ATIVO"
    WITH 7 DOWN WIDTH 74 CENTERED.

/* Definição de Frames */

// Frame principal.
DEFINE FRAME frMain  SKIP(1)
    iIdProduto       AT 02      LABEL "ID..........."
    dtCadastro       AT 40      LABEL "Data Cadastro"
    chNome           AT 02      LABEL "Nome produto."
    chVendedor       AT 40      LABEL "Vendedor....."
    chDescProd       AT 02      LABEL "Desc Produto."
    chNomeEmp        AT 40      LABEL "Empresa......"
    dValor           AT 02      LABEL "Valor........"       HELP "Este campo aceita somente valores numéricos"                      
    lAtivo           AT 40      LABEL "Ativo........"       HELP "[SIM/NAO]"                                                           
    iQuantidade      AT 02      LABEL "Quantidade..."       HELP "Este campo aceita somente valores numéricos"                          
    btBuscar         AT 02                                  HELP "[ENTER]- Buscar  produto"                                          SPACE(02)
    btNovo                                                  HELP "[ENTER]- Cadastrar novo produto"                                   SPACE(02)
    btAlterar                                               HELP "[ENTER]- Alterar dados"                                            SPACE(02)
    btDeletar                                               HELP "[ENTER]- Deletar dados"                                            SPACE(02)
    btGerarRelatorio                                        HELP "[ENTER]- Gerar planilha de relatório"                              SPACE(02)            
    btCancelar                                              HELP "[ENTER]- Sair do programa"                                         
    brTTProduto     AT 02                                   HELP "[Del]- Deletar Produto | [F2]- Alterar dados | [F4]-Sair"               
    WITH WIDTH 78 ROW 2 OVERLAY SIDE-LABELS CENTERED KEEP-TAB-ORDER TITLE "Cadastro de Produtos".


// Frame de cadastro de produtos.
DEFINE FRAME frCadastrarProduto SKIP(1)
    chNome           AT 05 LABEL "Nome produto."                                                                                      SKIP(1)
    chDescProd       AT 05 LABEL "Desc Produto."                                                                                      SKIP(1)
    iQuantidade      AT 05 LABEL "Quantidade..."            HELP "Este campo aceita somente valores numéricos"                        SKIP(1)
    dValor           AT 05 LABEL "Valor........"            HELP "Este campo aceita somente valores numéricos"                        SKIP(1)
    chVendedor       AT 05 LABEL "Vendedor....."                                                                                      SKIP(1)
    chNomeEmp        AT 05 LABEL "Empresa......"                                                                                      SKIP(1)
    lAtivo           AT 05 LABEL "Ativo........"            HELP "[SIM/NAO]"                                                          SKIP(1)
    btSalvar         AT 09                                                                                                             SPACE(5) 
    btCancelarCadastro      
    WITH WIDTH 40 ROW 3 TOP-ONLY SIDE-LABELS CENTERED TITLE "Cadastrar novo produto".


// Frame de alteração de produtos.
DEFINE FRAME frAlterarProduto SKIP(1)
    chNome           AT 05 LABEL "Nome produto."                                                                                      SKIP(1)
    chDescProd       AT 05 LABEL "Desc Produto."                                                                                      SKIP(1)
    iQuantidade      AT 05 LABEL "Quantidade..."            HELP "Este campo aceita somente valores numéricos"                        SKIP(1)
    dValor           AT 05 LABEL "Valor........"            HELP "Este campo aceita somente valores numéricos"                        SKIP(1)
    chVendedor       AT 05 LABEL "Vendedor....."                                                                                      SKIP(1)
    chNomeEmp        AT 05 LABEL "Empresa......"                                                                                      SKIP(1)
    lAtivo           AT 05 LABEL "Ativo........"            HELP "[SIM/NAO]"                                                          SKIP(1)
    btSalvar         AT 09                                                                                                             SPACE(5) 
    btCancelarCadastro           
    WITH WIDTH 40 ROW 3 TOP-ONLY SIDE-LABELS CENTERED TITLE "Alterar produto".

/* Procedimentos */

// Abre a query para o browse da tabela de produtos (ttProduto).
PROCEDURE pQuery:
    OPEN QUERY qrBrTTProduto
        FOR EACH ttProduto NO-LOCK BY ttProduto.chDescProd.    
END PROCEDURE.


/* Verifica se o arquivo CSV contém dados válidos. 
Se houver, mostra os dados no browse. Se não houver, o
pergunta se o usuário deseja cadastrar.*/
PROCEDURE pVerificarTabela:
    RUN crudm.p(INPUT "VERIFICAR",
                INPUT iIdProduto,
                INPUT chNome,
                INPUT chDescProd,
                INPUT iQuantidade,
                INPUT dValor,
                INPUT dtCadastro,
                INPUT chVendedor,
                INPUT chNomeEmp,
                INPUT lAtivo,
                INPUT iEUnidadeEmp,
                INPUT chENomeEmp,
                INPUT chCep,
                INPUT chCnpj,
                INPUT chEndereco,
                INPUT chRazaoSocial,
                INPUT chLogin,
                INPUT chVNome,
                INPUT iSetor,
                INPUT iSecao,
                INPUT iUnidadeEmp,
                INPUT dSalario,
                INPUT chEmail,
                INPUT chTelefone,
                INPUT-OUTPUT TABLE ttProduto,
                INPUT-OUTPUT TABLE ttVendedor,
                INPUT-OUTPUT TABLE ttEmpresa,
                OUTPUT lErro,
                OUTPUT chMensagemErro) NO-ERROR.
      RUN pQuery.
   FIND FIRST ttProduto WHERE ttProduto.iIdProduto > 0 NO-LOCK NO-ERROR.
        IF NOT AVAILABLE ttProduto THEN DO:
            MESSAGE "Nao existem dados cadastrados. Deseja incluir um novo registro?" 
            VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE lConfirmar AS LOGICAL.     
            IF lConfirmar THEN DO:
                RUN pCadastrarProduto.
            END.
            ELSE DO:
                QUIT.
            END.
        END.
END PROCEDURE.


// Inicializa o frame principal.
PROCEDURE pInicializarFrame:
    DISPLAY iIdProduto chNome chDescProd iQuantidade dValor dtCadastro chVendedor chNomeEmp lAtivo 
            btBuscar btNovo btAlterar btDeletar btCancelar 
    WITH FRAME frMain.
    RUN pVerificarTabela.
    ENABLE ALL WITH FRAME frMain.
    WAIT-FOR "WINDOW-CLOSE" OF CURRENT-WINDOW.
END PROCEDURE.


// Abre o frame de cadastro de produtos e libera os inputs para entrada de valores.
PROCEDURE pCadastrarProduto:
    DISPLAY chNome chDescProd iQuantidade dValor chVendedor chNomeEmp lAtivo 
        WITH FRAME frCadastrarProduto.
    ENABLE ALL WITH FRAME frCadastrarProduto.
    WAIT-FOR "WINDOW-CLOSE" OF CURRENT-WINDOW.
END PROCEDURE.

// Abre o frame de alteração de produtos e libera os inputs para entrada de valores.
PROCEDURE pAlterarProduto:
      FIND CURRENT ttProduto EXCLUSIVE-LOCK NO-ERROR.
      ASSIGN iIdProduto   = ttProduto.iIdProduto
             chNome       = ttProduto.chNome
             chDescProd   = ttProduto.chDescProd
             iQuantidade  = ttProduto.iQuantidade
             dValor       = ttProduto.dValor
             chVendedor   = ttProduto.chVendedor
             chNomeEmp    = ttProduto.chNomeEmp
             lAtivo       = ttProduto.lAtivo NO-ERROR.
    DISPLAY chNome chDescProd iQuantidade dValor chVendedor chNomeEmp lAtivo 
        WITH FRAME frAlterarProduto.
    ENABLE ALL WITH FRAME frAlterarProduto.
    WAIT-FOR "WINDOW-CLOSE" OF CURRENT-WINDOW.
END PROCEDURE.


//  Deleta produto da tabela
PROCEDURE pDeletarProduto:
    FIND CURRENT ttProduto EXCLUSIVE-LOCK NO-ERROR.
    IF AVAILABLE ttProduto THEN DO:
       ASSIGN iIdProduto = ttProduto.iIdProduto.
       RUN crudm.p( INPUT "DELETAR",
                    INPUT iIdProduto,
                    INPUT chNome,
                    INPUT chDescProd,
                    INPUT iQuantidade,
                    INPUT dValor,
                    INPUT dtCadastro,
                    INPUT chVendedor,
                    INPUT chNomeEmp,
                    INPUT lAtivo,
                    INPUT iEUnidadeEmp,
                    INPUT chENomeEmp,
                    INPUT chCep,
                    INPUT chCnpj,
                    INPUT chEndereco,
                    INPUT chRazaoSocial,
                    INPUT chLogin,
                    INPUT chVNome,
                    INPUT iSetor,
                    INPUT iSecao,
                    INPUT iUnidadeEmp,
                    INPUT dSalario,
                    INPUT chEmail,
                    INPUT chTelefone,
                    INPUT-OUTPUT TABLE ttProduto,
                    INPUT-OUTPUT TABLE ttVendedor,
                    INPUT-OUTPUT TABLE ttEmpresa,
                    OUTPUT lErro,
                    OUTPUT chMensagemErro) NO-ERROR.
      IF lErro THEN DO:
          MESSAGE chMensagemErro VIEW-AS ALERT-BOX.
      END.
      ELSE DO:
          RUN pQuery.
          MESSAGE "Produto deletado com sucesso!" VIEW-AS ALERT-BOX.
      END.
      APPLY "ENTRY" TO brTTProduto IN FRAME frMain.
      RETURN NO-APPLY.
    END.
END PROCEDURE.

/* Eventos */

// Evento para buscar e filtrar a tabela a partir dos valores inseridos.
ON CHOOSE OF btBuscar IN FRAME frMain DO:
    ASSIGN INPUT iIdProduto 
                 chNome
                 chDescProd
                 iQuantidade
                 dValor
                 dtCadastro
                 chVendedor
                 chNomeEmp
                 lAtivo. 
    OPEN QUERY qrBrTTProduto
        FOR EACH ttProduto 
            WHERE (IF iIdProduto    =   0       THEN TRUE ELSE ttProduto.iIdProduto = iIdProduto)
              AND (IF chNome        =   ""      THEN TRUE ELSE ttProduto.chNome = chNome)
              AND (IF chDescProd    =   ""      THEN TRUE ELSE ttProduto.chDescProd = chDescProd)
              AND (IF iQuantidade   =   0       THEN TRUE ELSE ttProduto.iQuantidade = iQuantidade)
              AND (IF dValor        =   0       THEN TRUE ELSE ttProduto.dValor = dValor)
              AND (IF dtCadastro    =   ?       THEN TRUE ELSE ttProduto.dtCadastro = dtCadastro)
              AND (IF chVendedor    =   ""      THEN TRUE ELSE ttProduto.chVendedor = chVendedor)
              AND (IF chNomeEmp     =   ""      THEN TRUE ELSE ttProduto.chNomeEmp = chNomeEmp)
              AND (IF lAtivo        =   ?       THEN TRUE ELSE ttProduto.lAtivo = lAtivo).
    IF NOT AVAILABLE ttProduto THEN DO:
        MESSAGE "Sem resultados para esta pesquisa!" VIEW-AS ALERT-BOX.
        APPLY "ENTRY" TO brTTProduto IN FRAME frMain.
        RUN pQuery.
    END. 
    RETURN NO-APPLY.
END.


// Abre o frame de cadastrar produtos.
ON CHOOSE OF btNovo IN FRAME frMain DO:
    RUN pCadastrarProduto.
    ENABLE ALL WITH FRAME frMain.
END.


// Evento para o botão de salvar os dados inseridos no frame de cadastrar produtos.
ON CHOOSE OF btSalvar IN FRAME frCadastrarProduto DO:
    ASSIGN INPUT chNome
           INPUT chDescProd
           INPUT iQuantidade
           INPUT dValor
           INPUT chVendedor
           INPUT chNomeEmp
           INPUT lAtivo NO-ERROR.            
    RUN crudm.p(INPUT "CRIAR",
                INPUT iIdProduto,
                INPUT chNome,
                INPUT chDescProd,
                INPUT iQuantidade,
                INPUT dValor,
                INPUT dtCadastro,
                INPUT chVendedor,
                INPUT chNomeEmp,
                INPUT lAtivo,
                INPUT iEUnidadeEmp,
                INPUT chENomeEmp,
                INPUT chCep,
                INPUT chCnpj,
                INPUT chEndereco,
                INPUT chRazaoSocial,
                INPUT chLogin,
                INPUT chVNome,
                INPUT iSetor,
                INPUT iSecao,
                INPUT iUnidadeEmp,
                INPUT dSalario,
                INPUT chEmail,
                INPUT chTelefone,
                INPUT-OUTPUT TABLE ttProduto,
                INPUT-OUTPUT TABLE ttVendedor,
                INPUT-OUTPUT TABLE ttEmpresa,
                OUTPUT lErro,
                OUTPUT chMensagemErro) NO-ERROR.
    IF lErro THEN DO:
        MESSAGE chMensagemErro VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
        RUN pQuery.
        MESSAGE "Produto cadastrado com sucesso!" VIEW-AS ALERT-BOX. 
        APPLY "WINDOW-CLOSE" TO CURRENT-WINDOW.
        RETURN NO-APPLY.
    END.
END.

// Altera os valores do do produto de acordo com os dados inseridos no frame de alterar produto.
ON CHOOSE OF btSalvar IN FRAME frAlterarProduto DO:
    ASSIGN INPUT chNome
           INPUT chDescProd
           INPUT iQuantidade
           INPUT dValor
           INPUT chVendedor
           INPUT chNomeEmp
           INPUT lAtivo NO-ERROR.             
    RUN crudm.p(INPUT "ALTERAR",    
                INPUT iIdProduto,
                INPUT chNome,
                INPUT chDescProd,
                INPUT iQuantidade,
                INPUT dValor,
                INPUT dtCadastro,
                INPUT chVendedor,
                INPUT chNomeEmp,
                INPUT lAtivo,
                INPUT iEUnidadeEmp,
                INPUT chENomeEmp,
                INPUT chCep,
                INPUT chCnpj,
                INPUT chEndereco,
                INPUT chRazaoSocial,
                INPUT chLogin,
                INPUT chVNome,
                INPUT iSetor,
                INPUT iSecao,
                INPUT iUnidadeEmp,
                INPUT dSalario,
                INPUT chEmail,
                INPUT chTelefone,
                INPUT-OUTPUT TABLE ttProduto,
                INPUT-OUTPUT TABLE ttVendedor,
                INPUT-OUTPUT TABLE ttEmpresa,
                OUTPUT lErro,
                OUTPUT chMensagemErro) NO-ERROR.
    IF lErro THEN DO:
        MESSAGE chMensagemErro VIEW-AS ALERT-BOX.
    END.
    ELSE DO:
        RUN pQuery.
        MESSAGE "Produto alterado com sucesso!" VIEW-AS ALERT-BOX. 
        HIDE FRAME frAlterarProduto NO-PAUSE.
        APPLY "WINDOW-CLOSE" TO CURRENT-WINDOW.
    END.
END.

// Deletar o produto selecionado no browse .
ON CHOOSE OF btDeletar OR "DELETE" OF brTTProduto IN FRAME frMain DO:
    MESSAGE "Deletar o produto?" VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE lConfirmarDel AS LOGICAL.
    IF lConfirmarDel THEN DO:
         RUN pDeletarProduto.
    END.
END.

//  Cancela o cadastro do produto no frame de cadastros ao selecionar o botão de cancelar.
ON CHOOSE OF btCancelarCadastro IN FRAME frCadastrarProduto DO:
    ASSIGN INPUT chNome
                 chDescProd
                 chVendedor
                 chNomeEmp.
    IF chNome <> "" OR chDescProd <> "" OR chVendedor <> "" OR chNomeEmp <> "" THEN DO:
        MESSAGE "Cancelar cadastro? Você perderá dos dados já registrados." 
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE lConfirmar AS LOGICAL.
        IF lConfirmar THEN DO:
            APPLY "WINDOW-CLOSE" TO CURRENT-WINDOW.
            RETURN NO-APPLY.               
        END.
    END.
    ELSE DO:
        APPLY "WINDOW-CLOSE" TO CURRENT-WINDOW.
        RETURN NO-APPLY.     
    END.      
END.

// Esconde o frame de alterar produtos ao selecionar o botão de cancelar.
ON CHOOSE OF btCancelarCadastro IN FRAME frAlterarProduto DO:
      HIDE FRAME frAlterarProduto NO-PAUSE.
      APPLY "WINDOW-CLOSE" TO CURRENT-WINDOW.
END.
// Gera o relatório ao selecionar o botão de gerar relatório no frame (frMain)
ON CHOOSE OF btGerarRelatorio IN FRAME frMain DO: 
    RUN crudm.p(INPUT "RELATORIO",    
                INPUT iIdProduto,
                INPUT chNome,
                INPUT chDescProd,
                INPUT iQuantidade,
                INPUT dValor,
                INPUT dtCadastro,
                INPUT chVendedor,
                INPUT chNomeEmp,
                INPUT lAtivo,
                INPUT iEUnidadeEmp,
                INPUT chENomeEmp,
                INPUT chCep,
                INPUT chCnpj,
                INPUT chEndereco,
                INPUT chRazaoSocial,
                INPUT chLogin,
                INPUT chVNome,
                INPUT iSetor,
                INPUT iSecao,
                INPUT iUnidadeEmp,
                INPUT dSalario,
                INPUT chEmail,
                INPUT chTelefone,
                INPUT-OUTPUT TABLE ttProduto,
                INPUT-OUTPUT TABLE ttVendedor,
                INPUT-OUTPUT TABLE ttEmpresa,
                OUTPUT lErro,
                OUTPUT chMensagemErro) NO-ERROR.
    MESSAGE "Relatorio gerado com sucesso!" VIEW-AS ALERT-BOX.
END.

// Finaliza o programa ao selecionar o botão cancelar no frame principal
ON CHOOSE OF btCancelar IN FRAME frMain DO:
    QUIT.
END.


// Altera os dados do produto selecionado no frame
ON "F2" OF brTTProduto DO:
    RUN pAlterarProduto.
END.

/* Inicialização do Programa */
RUN pInicializarFrame.