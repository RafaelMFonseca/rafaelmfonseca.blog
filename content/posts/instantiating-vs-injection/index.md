---
title: "Quando usar Dependency injection?"
date: 2023-01-18T18:00:00-00:00
comments: true
draft: true
tags:
  - C#
  - Patterns
  - DesignPatterns
  - SOLID
---

Investiguei no código do efcore, alguns pontos me chamaram a atenção, então decidi escrever sobre isso aqui.
Quando usar Dependency injection? Quando simplesmente instanciar uma classe no próprio método?
São abordagens diferentes, cada uma tem suas vantagens e desvantagens.

# Dependency injection
- Quando você quer abtrair a lógica da classe.
- É recomendado usar DI quando as dependências de sua classe são "comportamentais" e podem variar com base na implementação ou ambiente.
- Exemplo: cliente A utiliza SQLite, cliente B utiliza PostgreSQL, podemos criar uma interface para os services e utilizar o Injector para decidir qual implementação deve ser utilizada.
- Com isso, você pode criar implementações testes do serviço para utilizar nos testes unitários, ou Mockar.
- O DI permite a configuração externa da implementação por cliente, o que é útil quando se trata de lidar com múltiplos clientes ou ambientes.
- Com o DI você também consegue controlar o escopo (lifespan) da dependência.
- Se você injetar a dependência, a classe não precisa saber qual é a dependência que está sendo injetada.

# Instanciar a dependência
- Quando você procura uma abordagem mais simples e direta, em que a classe é responsável por criar as suas próprias dependências.
- Isso pode ser mais fácil de entender e manter para projetos menores ou com equipes menos experientes.
- Além disso, coisas que não mudam podem ser instanciadas nessa abordagem.
- Se você instanciar a dependência dentro da classe, significa que você precisará saber exatamente qual é essa dependência.
- Instanciar a dependência é uma boa opção se você estiver criando uma instância apenas em um lugar ou em poucos lugares. Se for uma classe helper que é usada em muitos lugares (como Math, File, Path...), não é a melhor escolha.

# Entendendo um caso real (efcore)

No arquivo [DbSetFinder.cs](https://github.com/dotnet/efcore/blob/main/src/EFCore/Infrastructure/Internal/DbSetFinder.cs) existe a linha:
```csharp
var factory = new ClrPropertySetterFactory();
```

Antigamente essa classe era injetada, e hoje ela passou a ser instânciada dentro do método, e a [mensagem de commit explica tudo](https://github.com/dotnet/efcore/commit/b786b4614789e35986e7811fccc848ec543e428d):
```
Move caching of property access delegates to the model
This is because the dictionary access involved in looking up the delegates is a significant perf hit, and co-location of the accessors with the property/navigation for which they are used removes this overhead.

Since he model is not coupled to the service provider, this means that the delegate construction code is now not a replaceable service. The mitigation for this in the long term is to allow extensibility of the model to contain delegates created in different ways. For example, the factories used to create the delegates could be annotated onto the model.

Note that the delegates are not stored as annotations because the lazy creation needs to happen after the model is "built" and must be thread-safe, neither of which are supported by annotations. Also, this is pert-sensitive code and the lookup needs to be fast.
```

Motivos dessa modificação:
- Performance, o código precisa ser rápido.
- O serviço não era substituível.
- A criação do model deve ser thread-safe.

Novamente, depende da sua situação. Se o seu aplicativo tem a possibilidade de mudar ou tem flexibilidade dentro dos componentes, você pode querer usar injeção.
Se for razoavelmente estático, você pode instanciar diretamente.
No final do dia, a decisão de qual abordagem usar dependerá do tamanho do projeto, das necessidades de negócios e das habilidades da equipe de desenvolvimento.

Fontes: <br>
https://michaelscodingspot.com/class-instantiation-guidelines-2/ <br>
https://softwareengineering.stackexchange.com/questions/361893/instantiating-vs-injection <br>
https://stackoverflow.com/questions/3386889/difference-between-creating-new-object-and-dependency-injection <br>
https://softwareengineering.stackexchange.com/questions/190090/when-to-use-di-and-when-to-create-yourself-in-java <br>
https://stackoverflow.com/questions/29663616/dependency-injection-or-instantiating-database-class-object <br>
