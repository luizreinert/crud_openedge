// Temp-table para os dados de produtos 
DEFINE TEMP-TABLE ttProduto NO-UNDO
    FIELD iIdProduto        AS INTEGER          FORMAT ">9"                 LABEL "ID"
    FIELD chNome            AS CHARACTER        FORMAT "X(15)"              LABEL "Nome"
    FIELD chDescProd        AS CHARACTER        FORMAT "X(10)"              LABEL "Descricao"
    FIELD iQuantidade       AS INTEGER          FORMAT ">9"                 LABEL "Quantidade"
    FIELD dValor            AS DECIMAL          FORMAT "R$>>>,>>9,99"       LABEL "Valor"
    FIELD dtCadastro        AS DATE             FORMAT "99/99/9999"         LABEL "Data cad."  
    FIELD lAtivo            AS LOGICAL          FORMAT  "SIM/NAO"           LABEL "Ativo"        
    FIELD chVendedor        AS CHARACTER        FORMAT "X(15)"              LABEL "Vendedor"
    FIELD chNomeEmp         AS CHARACTER        FORMAT 'X(15)'              LABEL "Empresa".

// Temp-table para os dados de vendedores          
DEFINE TEMP-TABLE ttVendedor NO-UNDO
    FIELD chLogin           AS CHARACTER        FORMAT "X(15)"
    FIELD chNome            AS CHARACTER        FORMAT "X(15)"
    FIELD iSetor            AS INTEGER          FORMAT ">9"
    FIELD iSecao            AS INTEGER          FORMAT ">9"
    FIELD iUnidadeEmp       AS INTEGER          FORMAT ">9"
    FIELD dsalario          AS DECIMAL          FORMAT "R$>>>,>>9,99"
    FIELD chEmail           AS CHARACTER        FORMAT "X(15)"
    FIELD chTelefone        AS CHARACTER        FORMAT "(XX)XXXXX-XXXX". 


// Temp-table para os dados de empresas    
DEFINE TEMP-TABLE ttEmpresa NO-UNDO
    FIELD iUnidadeEmp       AS INTEGER          FORMAT ">9"
    FIELD chNomeEmp         AS CHARACTER        FORMAT "X(15)"
    FIELD chCep             AS CHARACTER        FORMAT "XXXXX-XXX"
    FIELD chCnpj            AS CHARACTER        FORMAT "XX.XXX.XXX/XXXX-XX"
    FIELD chEndereco        AS CHARACTER        FORMAT "X(15)"        
    FIELD chRazaoSocial     AS CHARACTER        FORMAT "X(15)".