# Reactive Programming with Event Grid - Going Serverless all the Way

Events are everywhere in modern solutions - and although they are so important, you have to go to great lengths to get 
going before being productive: the infamous "plumbing" gets into your way. How about a solution that does all the event 
routing from to publisher to subscriber? Including registration, retry logic, monitoring as well as near real-time 
delivery built as a dynamically scaling platform as a service offering?

Azure Event Grid offers all of the above (and more) - and although being a relatively new service in Azure, quite a few 
services already publish to it. This means that for a lot of scenarios the old "hammer polling" and "exponential backoff" 
is a thing of the past, effectively saving money (compute and transactions) - which is obviously an important argument. 
However, Event Grid is not an Azure-services-only (or even Azure-only) solution: it serves well as a backbone for your 
applications-specfic events. Goodbye WebHook plumbing work, welcome push-push!

Christoph is MVP for Azure and publishes the code of his projects on [https://github.com/christophwille ](https://github.com/christophwille )
(includes Windows as well Azure projects). He is an independent consultant, supporting companies in everything 
Windows and Web (he was ASP.NET MVP for ten+ years). Aside from working on his own projects, 
he is also involved in other OSS projects, such as [ILSpy](https://github.com/icsharpcode/ILSpy).  You can reach him 
via [https://twitter.com/WilleChristoph](https://twitter.com/WilleChristoph).

## Azure Event Grid Official Links

* [Event Grid Homepage](https://azure.microsoft.com/en-us/services/event-grid/)
* [Docs: Overview](https://docs.microsoft.com/en-us/azure/event-grid/overview)
* [Docs: Choose between Azure services that deliver messages](https://docs.microsoft.com/en-us/azure/event-grid/compare-messaging-services) also check out [Events, Data Points, and Messages - Choosing the right Azure messaging service for your data](https://azure.microsoft.com/en-us/blog/events-data-points-and-messages-choosing-the-right-azure-messaging-service-for-your-data/) by Clemens Vasters
* [CloudEvents open standard support](https://azure.microsoft.com/en-us/blog/better-integrations-and-higher-productivity-with-azure-event-grid/)

## Generic Articles and Videos

* [What's new for Serverless Computing in Azure](https://channel9.msdn.com/Events/Build/2018/BRK2137)
* [Connect Anything to Everything: Serverless Routing and Messaging with Event Grid](https://channel9.msdn.com/Events/Build/2018/THR3509)
* [Be an integration superhero with Azure and build API-enabled and connected enterprises](https://channel9.msdn.com/Events/Build/2018/BRK2113)
* [Article: Event-Driven Architecture in the Cloud with Azure Event Grid](https://msdn.microsoft.com/en-us/magazine/mt829271) with [code repo](https://github.com/dbarkol/AzureEventGrid)
* [On .NET: Cloud scale events with Azure Event Grid](https://channel9.msdn.com/Shows/On-NET/Cloud-scale-events-with-Azure-Event-Grid)
* [Azure Event Grid: Powering serverless through eventing](https://www.youtube.com/watch?v=SaOWhPTjHn0) (Ignite conference) also check out [Events, Data points and Messages](https://www.youtube.com/watch?v=ITrlLErsqzY) by Clemens Vasters
* [Article: An Introduction to Azure Event Grid](https://www.red-gate.com/simple-talk/cloud/cloud-development/introduction-azure-event-grid/)

## Sample Code

* [Azure Code Samples - Event Grid](https://azure.microsoft.com/en-us/resources/samples/?sort=0&service=event-grid)
* [EventGrid/Azure Function demo](https://www.codeproject.com/Articles/1220389/Azure-EventGrid-Azure-Function-demo)
* [Azure Event Grid Viewer with ASP.NET Core and SignalR](https://madeofstrings.com/2018/03/14/azure-event-grid-viewer-with-asp-net-core-and-signalr/)
* [Event-Grid-Glue](https://github.com/JeremyLikness/Event-Grid-Glue), article [Glue for the Internet](https://blog.jeremylikness.com/azure-event-grid-glue-for-the-internet-e770d94cc29)
* [Azure Event Grid extension for VS Code](https://github.com/Microsoft/vscode-azureeventgrid)