test_that("sel_filter", {
  expect_equal(sel_filter(mtcars),
               mtcars %>%
                 select(mpg,cyl) %>%
                 filter(cyl == 6))
})
