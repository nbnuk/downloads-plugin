/*
 * Copyright (C) 2016 Atlas of Living Australia
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 */

// These are sensible defaults that are copied into the application's config object and can be overridden
// by the client application or its external config file

downloads.indexedDownloadUrl = "https://biocache.ala.org.au/ws/occurrences/offline/download"
downloads.checklistDownloadUrl = "https://biocache.ala.org.au/ws/occurrences/facets/download"

// For online fieldguide generation use biocache-hub webservice url e.g. http://biocache.ala.org.au/occurrences/fieldguide/download
// For offline fieldguide generation use fieldguide url e.g. http://fieldguide.ala.org.au
downloads.fieldguideDownloadUrl = "https://fieldguide.ala.org.au"

downloads.indexedFieldsUrl = "https://biocache.ala.org.au/ws/index/fields"

// The parent application should also use biocache.baseUrl, e.g. biocache-hubs
biocache.baseUrl = "https://biocache.ala.org.au/ws"

// Define userdetails.baseUrl to enable saving of fields to userdetails instead of cookies.
// e.g. userdetails.baseUrl = "https://auth.ala.org.au/userdetails"
userdetails.baseUrl = ""

downloads {
    customSections {
        //darwinCore = ["recordLevelTerms","occurrence","organism","materialSampleSpecimen","location","geologicalContext","identification","taxon","measurementOrFact","resourceRelationship"],
        darwinCore = ["recordLevelTerms", "occurrence", "organism", "event", "location", "identification", "taxon", "measurementOrFact"] // "geologicalContext", "resourceRelationship"
        speciesTraits = ["conservationStatus", "otherTraits"]
        spatialIntersections = ["environmentalLayers", "contextualLayers"]
        misc = ["qualityAssertions","miscellaneousFields"]
    }
    classMappings {
        Record = "recordLevelTerms"
        Occurrence = "occurrence"
        Organism = "organism"
        Event = "event"
        Location = "location"
        GeologicalContex = "geologicalContext"
        Identification = "identification"
        Taxon = "taxon"
        MeasurementOrFact = "measurementOrFact"
        ResourceRelationship = "resourceRelationship"
    }
    groupingsFilterMap {
        // values used to link through to the index fields web page, via filter param
        recordLevelTerms = "classs:Record"
        occurrence = "classs:Occurrence"
        organism = "classs:Organism"
        event = "classs:Event"
        location = "classs:Location"
        identification = "classs:Identification"
        taxon = "classs:Taxon"
        measurementOrFact = "classs:MeasurementOrFact"
        conservationStatus = ".*Conservation"
        otherTraits = "species_group|species_subgroup"
        environmentalLayers = "name:el[0-9]*"
        contextualLayers = "name:cl[0-9]*"
        qualityAssertions = "assertion"
        miscellaneousFields = ""
    }
}

// other field mappings for classes TODO get from biocache-service
downloads.conservationStatus = ["austConservation.p","stateConservation.p"]
downloads.otherTraits = ["speciesGroups.p","species_subgroup"]
downloads.environmentalLayers = ["el.p"]
downloads.contextualLayers = ["cl.p"]
//biocache.downloads.extra = "dataResourceUid,dataResourceName.p,occurrenceStatus.p"

// legacy default fields taken from https://github.com/AtlasOfLivingAustralia/biocache-service/blob/master/src/main/java/au/org/ala/biocache/dto/DownloadRequestParams.java#L35
downloads.legacy.defaultFields = "uuid,catalogNumber,taxonConceptID.p,scientificName,vernacularName,scientificName.p,taxonRank.p,vernacularName.p,kingdom.p,phylum.p,classs.p,order.p,family.p,genus.p,species.p,subspecies.p,institutionCode,collectionCode,locality,decimalLatitude,decimalLongitude,geodeticDatum,decimalLatitude.p,decimalLongitude.p,coordinatePrecision,coordinateUncertaintyInMeters.p,country.p,ibra.p,imcra.p,stateProvince.p,cl959,minimumElevationInMeters,maximumElevationInMeters,minimumDepthInMeters,maximumDepthInMeters,individualCount,recordedBy,year.p,month.p,day.p,eventDate.p,eventTime.p,basisOfRecord,basisOfRecord.p,sex,preparations,informationWithheld.p,dataGeneralizations.p,speciesHabitats.p,outlierForLayers.p,taxonomicIssue.p,geospatiallyKosher"
downloads.mandatoryFields = ["recordLevelTerms","occurrence"]
downloads.excludeFields = ""
downloads.dwcFields = "uuid,catalogue_number,taxon_concept_lsid,raw_taxon_name,raw_common_name,scientificName.p,raw_taxon,common_name,kingdom,phylum,class,order,family,genus,species,subspecies_name,institution_code,collection_code,raw_locality,decimalLatitude,decimalLongitude,decimalLatitude.p,decimalLongitude.p,coordinatePrecision,coordinate_uncertainty,country,cl1048,cl21,state,cl23,min_elevation_d,max_elevation_d_rng,min_depth_d,max_depth_d,individualCount,collector,year,month,day.p,eventDate.p,eventTime.p,raw_basis_of_record,basis_of_record,raw_sex,preparations,informationWithheld.p,dataGeneralizations.p"
downloads.uidField = "row_key" // It was "uuid" for biocache 1.9.x

downloads.fieldguide.species.max = 1000
downloads.maxRecords = 1000000
downloads.staticDownloadsUrl = "https://downloads.ala.org.au"
downloads.dwcSchemaUrl = "https://raw.githubusercontent.com/tdwg/dwc/master/xsd/tdwg_dwcterms.xsd"
downloads.termsOfUseUrl = "http://www.ala.org.au/about-the-atlas/terms-of-use/#TOUusingcontent"
downloads.defaultDownloadFormat = "dwc"
downloads.includeRawDwcFields = "true" // keep it a string to be consistent with properties file

doiService.baseUrl = "http://doi.ala.org.au"
doiService.doiResolverUrl = "https://doi.org/"