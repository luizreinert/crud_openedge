# 📚 CRUD em PROGRESS OpenEdge ABL

Este projeto é um CRUD desenvolvido em **OpenEdge ABL (Advanced Business Language)**, utilizando **temp-tables** e manipulação de arquivos **.csv** como base de dados fictícia. O sistema permite cadastrar, consultar, atualizar, excluir e gerar relatórios sobre registros de vendedores, produtos, empresas e vendas.

## 📂 Estrutura de Arquivos

```shell
  ├── crudm.p # Módulo principal (regras de negócio)
  ├── crudv.p # Módulo de visualização (interface)
  ├── crud.i # Definição de temp-tables
  └── planilhas/
    ├── empresa.csv # Cadastro de empresas
    ├── produto.csv # Cadastro de produtos
    ├── vendedor.csv # Cadastro de vendedores
    └── relatorio.csv # Modelo de relatório gerado
```

## 📌 Funcionalidades

- **Cadastrar:** Adiciona novos registros nos arquivos `.csv`.
- **Consultar:** Lista registros cadastrados.
- **Atualizar:** Permite alterar informações de registros existentes.
- **Excluir:** Remove registros selecionados.
- **Gerar Relatório:** Cria um arquivo `relatorio.csv` com os dados especificados.

## 🚀 Como Executar

1. Abra o **Developer Studio** ou o ambiente de execução de arquivos `.p`.
2. Certifique-se de que todos os arquivos `.csv` estejam no mesmo diretório que os programas `.p`.
3. Execute o arquivo `crudv.p`:

```abl
RUN crudv.p.
```

## 📖 Observações

Este projeto foi desenvolvido com foco no aprendizado de manipulação de arquivos e estruturação de programas modulares em OpenEdge ABL.
