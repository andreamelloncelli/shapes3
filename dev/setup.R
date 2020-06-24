## Create a new package with RStudio

# Package setup -----------------------------------------------------------
install.packages("usethis")
## Use version control
usethis::use_git_config(
  scope = "user",
  user.name = "Andrea Melloncelli",
  user.email = "andrea.melloncelli@gmail.com"
)
usethis::use_git()


# avoid problem with the dev scripts: dev/package-utility.R (this file)
dir.create("dev")
# save this file in `dev` as `setup.R`
usethis::use_build_ignore("dev")

# Fill in the DESCRIPTION file
# rstudioapi::navigateToFile( "DESCRIPTION" )
usethis::use_description(
  list(
    Title = "Tidy Package",
    `Authors@R` = "person('Andrea', 'Melloncelli', email = 'andrea@vanlog.it', role = c('cre', 'aut'))",
    Description = "A sentence describing the package.",
    URL = "https://github.com/vanlog/shapes"
  )
)
usethis::use_lgpl_license( name = "Andrea Melloncelli" )  # You can set another license here
usethis::use_tidy_description()                           # sort fields and packages

## Common tasks
usethis::use_readme_md( open = FALSE )
# usethis::use_code_of_conduct()
# usethis::use_lifecycle_badge( "Experimental" )
# usethis::use_news_md( open = FALSE )


## Use tests
usethis::use_testthat()



# Develop -----------------------------------------------------------------

## Use test
devtools::use_test("triangle")


## Add a package
usethis::use_package( "dplyr" )
# add it to ROXYGEN or NAMESPACE

## If you want to use roxygen, enable ROXYGEN in the project.
# Menu: tools > Project options > build tools > generate the documentation with roxygen
# install.packages("roxygen2")
# file.remove("NAMESPACE")
devtools::document() # to fill NAMESPACE and documentation with ROXYGEN comments
# or roxygen2::roxygenise() # converts roxygen comments to .Rd files.
# or [Ctrl + Shift + D] in RStudio

# Load the package [CTRL + SHIFT + L] or install-and-reload [CTRL + SHIFT + B]

## Check the package for Cran or [CTRL + SHIFT + E]
devtools::check(document = FALSE) # check the package

## Add internal datasets
## If you want to provide data along with your package
usethis::use_data_raw( name = "my_dataset", open = FALSE )

## Tests
## Add one line by test you want to create
usethis::use_test( "hello" )

## Vignette
usethis::use_vignette("ThisTidyPackage")
devtools::build_vignettes()
# Install the package and see it with vignette("ThisTidyPackage")


# Deploy ------------------------------------------------------------------

devtools::missing_s3()

devtools::check()
# rhub::check_for_cran()

