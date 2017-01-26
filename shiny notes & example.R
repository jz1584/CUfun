library(shiny)

#Reactive()####
?reactive
#Whenever a reactive value changes, 
#any reactive expressions that depended on it are marked as "invalidated" and will automatically re-execute if necessary.

#Observe Event vs ObserveReactive####
?observeEvent
#observeEvent and eventReactive provide straightforward APIs for event handling that wrap observe and isolate
#observeEvent: perform 'an action'(eg. plotting,render text) in response to an event
#observeReactive: generate a calculated value in response to an event, similar to normal reactive expression,
                  #it only invalidates in response to the given event

?observe
# It doesn't yeild result & can't use as input for other reactive expression. 



