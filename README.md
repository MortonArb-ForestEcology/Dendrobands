# Living Collection Dendrobands
Scripts for analyzing tree dendrometer band data in the Oak Collection in the East Woods at The Morton Arboretum


********
## Overview:
********
## Development:
*We welcome contributions from any individual, whether code, documentation, or issue tracking.  
All participants are expected to follow the [code of conduct](https://github.com/PalEON-Project/modeling_met_ensemble/blob/master/code_of_conduct.md) for this project.*

- **Lead: Christy Rollinson, Forest Ecologist, Morton Arboretum, crollinson@mortonarb.org**
- Collected and/or lab analysis by: 
	* Drew Duckett
	* Bethany Zumwalde
	* Note: To add in non-RA personnel
	
- Contact for data: Christy Rollinson, Forest Ecologist, Morton Arboretum, crollinson@mortonarb.org

- Date of data collection
2017- present

- Information about geographic location of data collection
The Morton Arboretum Oak Collection, Lisle, IL

********
## Available Data
The following variables are available in our data (code, description, units):

### Dendrometer Bands
| Variable | Description | Units |
| -------- | ----------- | ----- |
| site | observation site; This should correspond to the name of a Living Collection (e.g. Oak Collection) or designated site as part of the Morton Arboretum group (e.g. King's Woods) | character string |
| plot | the plot where the dendrometer bands were measured (e.g. N115, HH115)  | character string |
| date_observed | date of observation in field  | Date: YYYY-MM-DD |
| genus | individual genus (e.g. Quercus)  | character string |
| species | individual specific epithet (species; e.g. rubra) | character string |
| id | identification in local & NPN; if accessioned, use accession ID | character string |
| observer | last name of observer; if necessary add first/middle initial | character string |
| date_entered | date data entered into local database | Date: YYYY-MM-DD |
| data_entry | name of person entering data into local database | character string |
| dist_from_collar | distance from the edge of the dendroband collar to the initial mark measured by calipers | mm |


********
## Workflow (how you should use this repository):
All scripts to be executed are in the "scripts/" directory. 
Scripts are generally R-based and should generate the dependent file structures as you go
If you clone/fork/branch this code for a different system, you will want to adjust these scripts for your particular system. 
Many of the numbered R scripts will call generalized functions (scripts without numbers). 
If you're looking for the nuts & bolts of how each step is done, these are the scripts to look at.

### Description of Workflow Scripts/Steps

#### Dendrometer
1. **dendroband_plotting_BZ.R**
This script uses data from dendrometer bands on trees within plots established in the East Woods of The Morton Arboretum.  It calculates basal area then converts for growth (mm/day). This script also plots the total movement of the band away from the collar.
3. **maps_dendrometer_bands.R**
This script creates a map of trees with dendrometer bands on them in the Oak Collection at The Morton Arboretum.
4. **dendroband_plotting.R**
This script was the original plotting script that is not currently in use.
