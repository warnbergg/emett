#' SummarizeResults
#'
#' Plots the performance metrics, creates tables, and compiles manuscript.
#' @param statistics List. Statistics list from the RunModelling call in RunStudy. No default.
#' @export
SummarizeResults<- function(statistics) {
    ## Error handling
    ## Create ROC-plots
    CreateRocPlot(results$predictions.list, device = "pdf")
    ## Create Mortality plot
    CreateMortalityPlot(results$predictions.list, device = "pdf")
    ## Create table of estimates
    estimates.with.ci <- ComputeConfidenceIntervals(boot.object = results$statistics, type = "basic")
    CreateEstimatesTable(estimates.with.ci, table.name = "estimates.table",
                         footnote = "latex", escape = FALSE, booktabs = TRUE,
                         file.format = "rmd")
    ## Create classification tables, i.e. reclassification tables
    tables <- CreateClassificationTables(results$predictions.list)
    ## Create coefficients table, i.e. measures for each individual model in SuperLearner
    CreateCoefficientsTable(sample=results$samples$test, outcomes=results$predictions.list$y.test,
                            pretty.model.nms = pretty.names,
                            booktabs = TRUE)
    ## Create classifier plots, i.e. roc plots for all different classifiers
    CreateClassifierPlots(sample=results$samples$test,
                          outcomes=results$predictions.list$y.test,
                          pretty.model.nms = pretty.names,
                          device = "pdf")
}