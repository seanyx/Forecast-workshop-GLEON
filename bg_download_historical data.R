require(neon4cast)
require(tidyverse)


aquatic_sites <- read_csv("https://raw.githubusercontent.com/eco4cast/neon4cast-targets/main/NEON_Field_Site_Metadata_20220412.csv") |>
  dplyr::filter(aquatics == 1)

lake_sites <- aquatic_sites %>%
  filter(field_site_subtype == 'Lake')

vars = c("air_temperature", "air_pressure", "relative_humidity", "surface_downwelling_longwave_flux_in_air", "surface_downwelling_shortwave_flux_in_air",
         "eastward_wind", "northward_wind")

# past stacked weather
df_past <- neon4cast::noaa_stage3()

#Other variable names can be found at https://projects.ecoforecast.org/neon4cast-docs/Shared-Forecast-Drivers.html#stage-2

noaa_past_allvars <- df_past |> 
  dplyr::filter(site_id %in% lake_sites$field_site_id,
                datetime >= ymd('2017-01-01'),
                variable %in% vars) |> 
  dplyr::collect()

noaa_past_allvars

save(noaa_past_allvars, file = "dat/noaa_past_allvars.RData")