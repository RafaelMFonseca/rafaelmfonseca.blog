---
title: "Aplicando os princípios SOLID em aplicações C#"
date: 2022-01-23T20:42:00-00:00
comments: true
draft: true
tags:
  - C#
  - Patterns
  - DesignPatterns
  - SOLID
---

# Single Responsibility Principle

- Classes e métodos devem realizar apenas uma responsabilidade única.
- Todos os elementos que formam uma única responsabilidade devem ser agrupados e encapsulados.
- Classes não devem herdar funcionalidades que não precisam, provavelmente a classe base está fazendo muita coisa (violação de SRP).
- É uma má ideia ter mais de uma interface, class, struct ou enum em um único arquivo. A razão para isso é que pode dificultar a localização de itens, apesar de termos o IntelliSense para nos ajudar.
- Você quer que as classes relacionadas sejam tão independentes quanto possível. Quanto mais dependente uma classe é de outra classe, maior o acoplamento(isso é conhecido como alto acoplamento). Quanto mais as classes são independentes umas das outras, menor a coesão. Isso é conhecido como baixa coesão.
- Evite escrever métodos com mais de 2 argumentos.
- Mantenha seus métodos pequenos.