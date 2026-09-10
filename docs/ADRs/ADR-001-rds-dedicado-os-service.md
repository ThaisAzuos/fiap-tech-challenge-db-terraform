# ADR 001 — RDS PostgreSQL Dedicado ao OS Service (Fase 4)

**Status:** Aceita
**Data:** 2026-07-10
**Fase:** Tech Challenge Fase 4 — FIAP SOAT

---

## Contexto

Na Fase 3, a instância RDS PostgreSQL provisionada por este repositório era o único banco de dados da aplicação monolítica `fiap-tech-challenge-app`. Na Fase 4, o domínio é decomposto em três microsserviços de negócio (ver ADR-005 em `fiap-tech-challenge-app`), cada um exigindo banco de dados próprio, sem acesso direto ao banco de outro serviço.

## Decisão

Manter a instância RDS PostgreSQL provisionada por este repositório, agora de uso **exclusivo do OS Service** (`fiap-tech-challenge-app`, reduzido de escopo). Os novos serviços (Billing Service e Execution Service) **não** utilizam este banco — cada um usa sua própria instância de MongoDB, provisionada via Helm dentro do cluster gerenciado por `fiap-tech-challenge-k8s-terraform` (ver ADR correspondente nesse repositório e ADR-008 em `fiap-tech-challenge-app`).

Nenhuma mudança de infraestrutura Terraform é necessária neste repositório para a Fase 4 além desta clarificação de escopo/documentação.

## Alternativas consideradas

- **Provisionar uma instância RDS por serviço (uma para cada microsserviço)**: rejeitada; o requisito do desafio pede ao menos um banco relacional e um não relacional no sistema como um todo, não necessariamente um SQL por serviço — manter um único RDS dedicado ao OS Service atende ao requisito com menor esforço e tempo de provisionamento.
- **Compartilhar este RDS entre os três serviços, com schemas separados**: rejeitada; violaria diretamente o requisito obrigatório de que nenhum serviço acesse o banco de outro.

## Consequências

- O README deste repositório precisa deixar explícito que o RDS aqui provisionado é de uso exclusivo do OS Service, evitando que outros serviços sejam apontados para ele por engano.
- Os bancos NoSQL dos demais serviços não são geridos por este Terraform — ficam sob responsabilidade do `fiap-tech-challenge-k8s-terraform` (Helm) e de cada repositório de serviço.
