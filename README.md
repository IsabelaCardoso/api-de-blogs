# ApiDeBlogs

# Desafio Técnico Back-end - Api de Blogs

Esse projeto é a minha solução para o desafio do processo seletivo da Trybe. A proposta foi desenvolver uma API de um Blog, onde seria possível criar um usuário e publicações.

## Detalhes da aplicação

A aplicação permite ao usuário:
* Se cadastrar
* Fazer login
* Buscar os usuários cadastrados
* Buscar usuário por id
* Deletar o seu próprio usuário
* Criar posts
* Buscar todos os posts
* Buscar post por id

## Instalação

```ssh
$ mix deps.get
$ mix ecto.create
$ mix ecto.migrate
$ MIX_ENV=test mix ecto.create
$ MIX_ENV=test mix ecto.migrate
```

## Iniciar o servidor:

```sh
$ iex -S mix phx.server
```

## Rodar todos os testes

```sh
$ mix test

```

## Pré-requisitos

- Elixir 1.11.4
- Erlang 23+
- PostgreSQL 14.1

## Observações

### Requisitos e melhorias para o código

Acrescentar funcionalidades:
* Editar um post
* Buscar post por termo pesquisado
* Deletar um post

Outros:
* Testar 100% da aplicação
* Trabalhar todos os casos de erros
