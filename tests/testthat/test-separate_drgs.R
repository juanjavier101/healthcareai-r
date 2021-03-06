context("separate_drgs")

MSDRGs <- c("ACUTE & SUBACUTE ENDOCARDITIS W CC", "ACUTE & SUBACUTE ENDOCARDITIS W MCC",
            "ACUTE ADJUSTMENT REACTION & PSYCHOSOCIAL DYSFUNCTION", "ACUTE LEUKEMIA W/O MAJOR O.R. PROCEDURE W CC",
            "ACUTE LEUKEMIA W/O MAJOR O.R. PROCEDURE W MCC", "ACUTE LEUKEMIA W/O MAJOR O.R. PROCEDURE W/O CC/MCC",
            "ACUTE MAJOR EYE INFECTIONS W CC/MCC", "ACUTE MYOCARDIAL INFARCTION, DISCHARGED ALIVE W CC",
            "ACUTE MYOCARDIAL INFARCTION, DISCHARGED ALIVE W MCC", "ACUTE MYOCARDIAL INFARCTION, DISCHARGED ALIVE W/O CC/MCC",
            "ACUTE MYOCARDIAL INFARCTION, EXPIRED W CC", "ACUTE MYOCARDIAL INFARCTION, EXPIRED W MCC",
            "ADMIT FOR RENAL DIALYSIS", "ADRENAL & PITUITARY PROCEDURES W CC/MCC",
            "ADRENAL & PITUITARY PROCEDURES W/O CC/MCC", "AFTERCARE W CC/MCC",
            "AFTERCARE, MUSCULOSKELETAL SYSTEM & CONNECTIVE TISSUE W CC",
            "AFTERCARE, MUSCULOSKELETAL SYSTEM & CONNECTIVE TISSUE W MCC",
            "AFTERCARE, MUSCULOSKELETAL SYSTEM & CONNECTIVE TISSUE W/O CC/MCC",
            "AICD GENERATOR PROCEDURES", "ALCOHOL/DRUG ABUSE OR DEPENDENCE W/O REHABILITATION THERAPY W MCC",
            "ALCOHOL/DRUG ABUSE OR DEPENDENCE W/O REHABILITATION THERAPY W/O MCC",
            "ALCOHOL/DRUG ABUSE OR DEPENDENCE, LEFT AMA", "ALLERGIC REACTIONS W MCC",
            "ALLERGIC REACTIONS W/O MCC", "ALLOGENEIC BONE MARROW TRANSPLANT",
            "AMPUTAT OF LOWER LIMB FOR ENDOCRINE,NUTRIT,& METABOL DIS W CC",
            "AMPUTAT OF LOWER LIMB FOR ENDOCRINE,NUTRIT,& METABOL DIS W MCC",
            "AMPUTATION FOR CIRC SYS DISORDERS EXC UPPER LIMB & TOE W CC",
            "AMPUTATION FOR CIRC SYS DISORDERS EXC UPPER LIMB & TOE W MCC",
            "AMPUTATION FOR MUSCULOSKELETAL SYS & CONN TISSUE DIS W CC",
            "AMPUTATION FOR MUSCULOSKELETAL SYS & CONN TISSUE DIS W MCC",
            "ANAL & STOMAL PROCEDURES W CC", "ANAL & STOMAL PROCEDURES W MCC",
            "ANAL & STOMAL PROCEDURES W/O CC/MCC", "ANGINA PECTORIS", "AORTIC AND HEART ASSIST PROCEDURES EXCEPT PULSATION BALLOON W MCC",
            "WND DEBRID & SKN GRFT EXC HAND, FOR MUSCULO-CONN TISS DIS W MCC",
            "WND DEBRID & SKN GRFT EXC HAND, FOR MUSCULO-CONN TISS DIS W/O CC/MCC",
            "WOUND DEBRIDEMENTS FOR INJURIES W MCC", "WOUND DEBRIDEMENTS FOR INJURIES W/O CC/MCC"
)
out <- separate_drgs(MSDRGs)

test_that("separate_drgs returns a tibble", {
  expect_s3_class(out, "tbl_df")
})

test_that("every base_msdrg is in the original drg", {
  expect_true(all(stringr::str_detect(out$msdrg, stringr::fixed(out$base_msdrg))))
})

test_that("the input vector is returned unchanged", {
  expect_true(all.equal(out$msdrg, MSDRGs))
})

with_age <- c("OTHER KIDNEY & URINARY TRACT DIAGNOSES AGE 0-17",
              "OTHER DIGESTIVE SYSTEM DIAGNOSES AGE >17",
              "CRANIOTOMY & ENDOVASCULAR INTRACRANIAL PROCEDURES AGE >17")

test_that("separate_drgs can remove ages", {
  out <- separate_drgs(with_age, remove_age = TRUE)
  expect_false(any(grepl("age", out$base_msdrg, ignore.case = TRUE)))
  expect_equal("OTHER KIDNEY & URINARY TRACT DIAGNOSES", out$base_msdrg[1])
})

test_that("all output is missing when input is missing", {
  MSDRGs <- c(NA, MSDRGs)
  out <- separate_drgs(MSDRGs)
  expect_true(all(is.na(out[1, ])))
})
