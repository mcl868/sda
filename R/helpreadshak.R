helpreadshak <-  function() {
  path <- "https://sor-filer.sundhedsdata.dk/sor_produktion/data/shak/shakregion/SHAKregion.txt"
  if(url.exists(path)){
    SHAK <- suppressMessages(read_delim(path,
                                        delim = "\t", escape_double = FALSE,
                                        col_names = FALSE, trim_ws = TRUE, locale = locale(encoding = "latin1")))
    colnames(SHAK) <- c("K_SGH", "V_SGHNAVN", "K_FRADTO", "D_TILDTO", "C_SGHTYPE", "C_INSTART", "C_REGION", "C_SORID")
  
    SHAK <- data.frame(SHAK)
    SHAK <- SHAK %>% mutate(Region = NA_character_,
                            Region = if_else(C_REGION %in% 1081, "Nordjylland", Region),
                            Region = if_else(C_REGION %in% 1082, "Midtjylland", Region),
                            Region = if_else(C_REGION %in% 1083, "Syddanmark", Region),
                            Region = if_else(C_REGION %in% 1084, "Hovedstaden", Region),
                            Region = if_else(C_REGION %in% 1085, "Sj\u00e6lland", Region),
                            Institution = NA_character_,
                            Institution = if_else(C_SGHTYPE %in% 1, "Offentlig", Institution),
                            Institution = if_else(C_SGHTYPE %in% 2, "Privat", Institution),
                            Institution = if_else(C_SGHTYPE %in% 3, "\u00d8vrige", Institution),
                            K_FRADTO = paste0(substr(K_FRADTO, 1, 4), "-", substr(K_FRADTO, 5, 6), "-", substr(K_FRADTO, 7, 8)),
                            D_TILDTO = paste0(substr(D_TILDTO, 1, 4), "-", substr(D_TILDTO, 5, 6), "-", substr(D_TILDTO, 7, 8)))
SHAK$K_FRADTO <- as.Date(SHAK$K_FRADTO)
SHAK$D_TILDTO <- as.Date(SHAK$D_TILDTO)

    SHAK$C_REGION <- NULL
    SHAK$C_SGHTYPE <- NULL
    return(SHAK)
  } else {warning("The link does not work. Write to thomas.maltesen@proton.me")}
}
