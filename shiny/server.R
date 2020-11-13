
library(shiny)


shinyServer(function(session,input, output) {
    observe({
        r<-input$regressor
        updateSliderInput(session, "regrpred",min=min(longley[[r]]),max=max(longley[[r]]))
    })
    modelpred<-reactive({
       r<-input$regressor
       p1<-input$regrpred
       y<-longley$Employed
       x<-longley[[r]]
       model<-lm(y ~ x,data=longley)
       pr<-predict(model,newdata=data.frame(x=p1))
    })

    output$plot1 <- renderPlotly({
        p1<-input$regrpred
        r<-input$regressor
        model<-lm(longley$Employed ~ longley[[r]],data=longley)
        pred.int<-predict(model, newdata=longley, interval="prediction")
        mydata <- cbind(longley, pred.int)
        p<-ggplot(longley,aes(longley[[r]],Employed))+geom_point()+stat_smooth(method=lm)
        p<-p+geom_line(aes(y=mydata$lwr),color="red",linetype="dashed")+geom_line(aes(y=mydata$upr),color="red",linetype="dashed")+labs(x=r)
        p+geom_point(aes(x=p1, y=modelpred()), colour="yellow",size=2)
    })
    output$pred1<-renderText({
        modelpred()
    })
    

})
