# Shadowfleet owners

This repository is part of an international investigation into the owernship of the Russian shadowfleet. We are interested in who sold shadowfleet vessels to whom or which companies have been managing the fleet. This is quite hard to figure out, because of the opacity of ownership structures. With this repository we want to get as far as we can get with publicly available data.

## Definition

A vessel is part of the shadowfleet if it carries Russian crude or oil products, while under or uninsured, owned by a non-EU/G7 company.

## Data sources and caveats

1. List of shadowfleet vessels by the Kiev School of Economics Institute. The KSE provided this list with an overview of amount of oil carried sometime in a certain month while under or uninsured. For practical purposes we assume these vessels were part of the shadowfleet for that whole month. If it's important, please check the exact status of the vessel on the moment that is important for you analysis. For instance, it could be the case that a shadowfleet vessel entered a port at a certain date, but that it just got P&I insurance, so it was at that moment technically not part of the shadowfleet.

2. Historical vessel details from Equasis. We've downloaded all the historical data on vessels in Equasis. This data consists of:
    - names used for the vessel
    - inspections
    - involved companies (managing and owning the vessel)
    - history of flag nations

3. Historical data on companies managing or owning the vessels, downloaded from Equasis, specifically:
    - Address information
    - Other vessels currently managed or owned. These documents don't show previous vessels these company have managed or owned. 

4. Data on vessel behaviour downloaded from Global Fishing Watch:
    - port visits
    - loitering behavior
    - historical tracks (AIS)
    - ais off switching events
    These events are the result of calculations on AIS signals performed by Global Fishing Watch. This means that the data is probabilistic and should be treated as such. Also AIS data can be spoofed, so if the exact location is important for the story, please double check with other sources. [Here](https://globalfishingwatch.org/datasets-and-code/) you can find more information on the GFW data.

5. Vessel particulars downloaded from IHS. These files are quite similar to the Equasis vessel files (which uses IHS as a source), but also contain information on beneficial ownership. In our experience the IHS data is more reliable than the Equasis data, but we got these files in a late stage of our research.

Additionally we have used geometries of well known ship to ship transfer locations (Gulf of Laconia, Malta, Augusta, Lome, Dakar and Johor) to identify long stays of vessels. Vessels that were just passing through are deleted from this dataset.

While researching some national media teams made their own choices which vessels to include. For instance, NRK added a vessel to their list, that is not on the KSE list. As a consequence the aggregated data in this project might differ slightly from the aggregated data in the national projects. We have opted to be as consistent with the KSE definition as possible. 

## The code

This is a big project, so I've created a lot of code and tried some different approaches, some of which weren't used in the end product.

- Data acquisition code (GFW) can be found in [shadowfleet.py](src/shadowfleet.py)
- Several notebooks can be found in [notebooks](notebooks/):
  - [Data import and cleaning](notebooks/data_import_and_cleaning.ipynb)
  - [Preparation for PostgreSQL database](notebooks/db_prep.ipynb)
  - [Code used for creating a timeline per vessel](notebooks/create_timeline.ipynb)
  - [Some preliminary analysis](notebooks/analysis.ipynb)
  - [Some preliminary code to research the role of commodity traders](notebooks/commodity_traders.ipynb)
- [SQL statements for use in metabase](sql/)

## Docker files

The repository contains some docker configuration files. These were used for an experiment with Neo4J, but can be adapted to create a docker container for the whole project.

