# Propensity score
    m_ps <- glm(ortho_in_24 ~ iss +
                  transfer +
                  TBI +
                  ed_initial_gcs +
                  ed_lowest_hr +
                  ed_lowest_sbp +
                  INR +
                  ex_lap_24 +
                  proc_other_24,
                family = binomial(), data = df)
    summary(m_ps)
    
    prs_df <- data.frame(pr_score = predict(m_ps, type = "response"),
                         ortho_in_24 = m_ps$model$ortho_in_24)
    
    prediction <- predict(m_ps, df, interval = "prediction", type="response") # predict on all
    my_data <- cbind(df_prop, prediction) # bind prediction to data

# Linear mixed effects model
    lme.results <- lme(Concentration ~ hour + delta_surg_time2 + prediction, random=~1|stnum, data = df.i, method="REML")