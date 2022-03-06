---
title: "Conceitos da Programação Orientada a Objetos"
date: 2022-03-06T12:38:00-00:00
comments: true
tags:
  - C#
  - SOLID
  - OOP
---

# Tabela de contúdo
1. [Single Responsibility Principle](single-responsibility-principle)
2. [Open-Closed Principle](open-closed-principle)
3. [Liskov Substitution Principle](liskov-substitution-principle)
4. [Interface Segregation Principle](interface-segregation-principle)
5. [Dependency Inversion Principle](dependency-inversion-principle)
6. [Coupling](coupling)
7. [Cohesion](cohesion)
8. [YAGNI - You Ain't Gonna Need It](yagni-you-aint-gonna-need-it)
9. [KISS - Keep It Simple, Stupid](kiss-keep-it-simple-stupid)
10. [Specialization](specialization)
11. [Generalization](generalization)
12. [Boy Scout Rule](boy-scout-rule)
13. [DRY - Don't repeat yourself](dry-dont-repeat-yourself)
14. [Feature Envy](feature-envy)
15. [Single Line Responsibility](single-line-responsibility)

# Single Responsibility Principle
*(Princípio da responsabilidade única)*
- Classes e métodos devem realizar apenas uma responsabilidade única.
- Todos os elementos que formam uma única responsabilidade devem ser agrupados e encapsulados.
- Classes não devem herdar funcionalidades que não precisam, provavelmente a classe base está fazendo muita coisa (violação de SRP).
- É uma má ideia ter mais de uma interface, class, struct ou enum em um único arquivo. A razão para isso é que pode dificultar a localização de itens, apesar de termos o IntelliSense para nos ajudar.
- Você quer que as classes relacionadas sejam tão independentes quanto possível.
- Evite escrever métodos com mais de 2 argumentos.
- Mantenha seus métodos pequenos.

# Open-Closed Principle
- Permitir adicionar/estender novas funcionalidades com mudança mínimas no código existente, ou seja, inalterar o código existente.
- Ou seja, estender seus comportamentos deve ser fácil, mas ao mesmo tempo deve ser fechada para alterações(seu código não deve ser alterado o tempo todo).
> TODO...

# Liskov Substitution Principle
- Uma classe derivada pode ser substituída pela sua classe base.
> TODO...

# Interface Segregation Principle
- Muitas interfaces específicas são melhores do que uma para todos os propósitos.
> TODO...

# Dependency Inversion Principle
*(Princípio da inversão de dependência)*
- Deve-se depender de abstrações (interfaces, etc) e não de objetos concretos.
- Como as classes, cada interface deve ter uma responsabilidade única. (SRP)
- Assim, faz com que a classe implemente apenas os métodos necessários, evitando que ela implemente um método da interface que a classe não usa.
> TODO...

# Coupling
*(Acoplamento)*
- É uma medida de relacionamento e define o grau de dependência entre as classes.
- Refere-se ao nível em que uma classe conhece ou usa membros de uma outra classe.
- Herança é um tipo de acoplamento alto que devemos evitar, pois alteração de implementações de métodos na superclasse vai afetar todas as subclasses, podemos resolver utilizando: composição, classes abstratas, interfaces, injeção de dependência e encapsulamento.
> - Baixo acoplamento **(desejável)**: classes bem encapsuladas que minimizam as referências umas às outras.
> - Alto acoplamento **(indesejável)**: classes com uma grande dependência em relação à outras.

# Cohesion
*(Coesão)*
- Refere-se ao nível em que uma classe tem de único e bem definido papel ou responsabilidade.
- Mundo ideal: em uma classe bem-definida, você quer <ins>alta coesão e baixo acoplamento</ins>.
- Quanto maior for a coesão, menor será o nível de acoplamento de um módulo.
- Classes com alta coesão são menos alteradas, fáceis de manter, entender e reusar.
> - Alta coesão **(Desejável)**: códigos corretamente agrupados.
> - Baixa coesão **(Indesejável)**: códigos agrupados que dão suporte a vários papéis e responsabilidades e que não pertencem juntos. 

# YAGNI - You Ain't Gonna Need It
> TODO...

# KISS - Keep It Simple, Stupid
> TODO...

# Specialization
> TODO...

# Generalization
> TODO...

# Boy Scout Rule
> TODO...

# DRY - Don't repeat yourself
> TODO...

# Feature Envy
> TODO...

# Single Line Responsibility
*(Linha de responsabilidade única)*
- É um princípio que cita uma regra simples: use cada linha para fazer apenas uma coisa.
- Evite criar objetos ou parâmetros chamando métodos e usando condições.
- SLR não é uma regra estrita, às vezes uma linha é apropriada para certas coisas.
- Seguir o SLR te dá a possibilidade de extrair funções úteis.

```csharp
// Estamos criando um objeto de pesquisa mas para cada parâmetro
// temos uma lógica especial para criar seus valores.
// Sem SLR:
return SearchFactory.SearchUrlObject(
    feature: features != null && features.Count() == 1 ? features[1] : null,
    urlPattern: isMap ? "Find" : "Contains");

// Refatorando seguindo o SLR, criamos uma variável para cada parâmetro
// Com SLR:
IFeature feature = features != null && features.Count() == 1 ? features[1] : null;
string urlPattern = isMap ? "Find" : "Contains";

return SearchFactory.searchUrlObject(feature, urlPattern);
```

```csharp
// Sem SLR:
numeros.Where(n => n % 2 == 0).Select(n => n * 2);

// Com SLR:
numeros
    .Where(n => n % 2 == 0)
    .Select(n => n * 2);
```