---
title: "Como eu penso quando estou programando em C#!"
date: 2022-03-11T11:42:00-00:00
comments: true
draft: true
tags:
  - C#
---

C# contém várias palavras-chaves e muitas funcionalidades que podem conflitar umas com as outras e gerar comportamentos estranhos. <br />
Quando estou programando, existe algumas linhas de pensamento que tento seguir que me ajuda a prever estes imprevistos, segue abaixo algum deles: <br />

**Observação:** vou incrementar este post com o tempo!

## Pensar no operador que estou usando:
---
> No c# existe a [sobrecarga de operador](https://docs.microsoft.com/pt-br/dotnet/csharp/language-reference/operators/operator-overloading), ao utilizar uma biblioteca de terceiros, lembre-se de que um `==` pode não ser o que você está pensando, use `is null` ao invés disso! Ou seja, se existe alguma funcionalidade especificamente para o que você quer, use-a!

```csharp
ThirdPartyImplem impl = null;

if (impl is null) // Seguro!
{
    Console.WriteLine("Impl é realmente nulo!");
}

if (impl == null) // Como funciona? 'ThirdPartyImplem' compara valores ou só a referência?
{
    Console.WriteLine("Preciso verificar a documentação!");
}
```
