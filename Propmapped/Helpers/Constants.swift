//
//  Constants.swift
//  Propmapped
//
//  Created by James Jamarsoft on 24/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

struct Constants {
    
    struct APIData {
        static let apiCrimeURL = "https://api.propertydata.co.uk/crime?key=DNUXB4S0G3";
        static let apiSchoolsURL = "https://api.propertydata.co.uk/schools?key=DNUXB4S0G3";
        static let apiDemographicsURL = "https://api.propertydata.co.uk/demographics?key=DNUXB4S0G3";
        static let apiCouncilURL = "https://api.propertydata.co.uk/council-tax?key=DNUXB4S0G3";
        static let apiDemandURL = "https://api.propertydata.co.uk/demand?key=DNUXB4S0G3";
        static let basicCrimeCells = 4;
        static let apiRestaurantURL = "https://api.foursquare.com/v2/venues/explore?client_id=4TPOQQM3VIH5H5JQS0A5XSENIEKXAEYSY0MZWGUR3WYHL31K&client_secret=TGHTS53YKRMQLZOLM3ZB2NDRYPLIVS0F0MQ23XSRU5HZSLHU&v=20180323&limit=1&ll=40.7243,-74.0018&query=restaurants";
    }
    
    struct CrimeHeadlines {
        static let population = "Population";
        static let crimesLast12m = "Crimes Last 12 months";
        static let crimesPerThousand = "Crimes per Thousand";
        static let crimeRating = "Crime Rating";
        static let allValues = ["Population","Crimes Last 12 months","Crimes per Thousand","Crime Rating"];
        static let section0 = "Crime Overview";
        static let section1 = "Crimes Committed";
        static let section2 = "Area vs. National Average";
    }
    
    struct CouncilTaxInfo {
        static let council = "Council";
        static let council_rating = "Council Rating";
        static let year = "Year";
        static let annual_change = "Annual Change";
        static let allValues = ["Council","Council Rating","Year","Annual Change"];
    }
    
    struct SchoolsStrings {
        static let independant = "Independent Schools";
        static let state = "State Schools";
        static let scores = "Rating";
        static let headers = ["Name","Local Authority","Post Code","Type","Phase","Sixth Form","Rating","Number of Pupils","Deprivation","Inspection Start","Inspection End","Inspection Published","URL", "Ages", "Gender"];
        
    }
    
    struct AreaDemand {
        static let totalForSale = "Total For Sale";
        static let averageSale = "Averare Sales per Month";
        static let turnover = "Turnover per Month";
        static let daysOnMarket = "Days on Market";
        static let demandRating = "Demand Rating";
        static let headers = ["Total For Sale", "Average Sales per Month", "Turnover per Month", "Days on Market", "Demand Rating"];
    }
    struct Keys {
        static let postCode = "postCode";
    }
    
    struct FirebaseKeys {
        static let users = "users"
        static let property = "propertyData"
        static let images = "images"
    }
    
    struct CoreDataKeys {
        static let favProp = "FavProp";
    }
    
    struct Property {
        static let allTypes = ["Flat","Detached","Terraced","Semi-Detached","Bungalow"]
        static let Flat = "Flat"
        static let Detached = "Detached"
        static let Terraced = "Terraced"
        static let Semi = "Semi-Detached"
        static let Bungalow = "Bungalow"
    }
    
    struct ChatMessages {
        static let appName = "Propmapped"
        static let cellIdentifier = "chatCell"
        static let cellNibName = "MessageCell"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct NearRest {
        static let name = "Name";
        static let address = "Address";
        static let type = "Type";
        static let hygiene = "Hygiene";
        static let ratingDate = "Rating Date";
        static let distance = "Distance";
        static let headers = ["Name", "Address", "Type", "Hygiene", "Rating Date", "Distance"]
    }
    
    struct RestaurantData {
        static let average = "Average Hygiene";
        static let propBad = "Proportion Bad";
        static let rating = "Rating";
        static let headers = ["Average Hygiene", "Proportion Bad", "Rating"]
    }
    
    struct Stamp {
        static let country = "Country Used"
        static let sdlt = "SDLT"
        static let rate = "Additional Rate Used"
        static let firstTime = "First Time Buyer"
        static let headers = ["Country Used", "SDLT", "Additional Rate Used", "First Time Buyer"]
    }
}
