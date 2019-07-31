//
//  IsectionsDimensionsParameters.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import Foundation

class IsectionsDimensionsParameters {
    
    // Below are the dimensions properties related to I-Sections cross-sections, these will be filled by extracting the relevant data from the corresponding CSV file:
    
    var _firstSectionSeriesNumber: Int!
    
    var _secondSectionSeriesNumber: Int!
    
    var _lastSectionSeriesNumber: Int!
    
    var _sectionSerialNumber: String!
    
    var _fullSectionDesignation: String!
    
    var _sectionMassPerMetre: Double!
    
    var _depthOfSection: Double!
    
    var _widthOfSection: Double!
    
    var _sectionWebThickness: Double!
    
    var _sectionFlangeThickness: Double!
    
    var _sectionRootRadius: Double!
    
    var _depthOfSectionBetweenFillets: Double!
    
    var _ratioForLocalWebBuckling: Double!
    
    var _ratioForLocalFlangeBuckling: Double!
    
    var _dimensionForDetailingEndClearance: Int!
    
    var _dimensionForDetailingNotchN: Int!
    
    var _dimensionForDetailingNotchn: Int!
    
    var _surfaceAreaPerMetre: Double!
    
    var _surfaceAreaPerTonne: Double!
    
    var _secondMomentOfAreaMajorAxis: Double!
    
    var _secondMomentOfAreaMinorAxis: Double!
    
    var _radiusOfGyrationMajorAxis: Double!
    
    var _radiusOfGyrationMinorAxis: Double!
    
    var _elasticModulusMajorAxis: Double!
    
    var _elasticModulusMinorAxis: Double!
    
    var _plasticModulusMajorAxis: Double!
    
    var _plasticModulusMinorAxis: Double!
    
    var _bucklingParameter: Double!
    
    var _torsionalIndex: Double!
    
    var _wrapingConstant: Double!
    
    var _torsionalConstant: Double!
    
    var _areaOfSection: Double!
    
    var firstSectionSeriesNumber: Int {
        
        return _firstSectionSeriesNumber
        
    }
    
    var secondSectionSeriesNumber: Int {
        
        return _secondSectionSeriesNumber
        
    }
    
    var lastSectionSeriesNumber: Int {
        
        return _lastSectionSeriesNumber
        
    }
    
    var sectionSerialNumber: String {
        
        return _sectionSerialNumber
        
    }
    
    var fullSectionDesignation: String {
        
        return _fullSectionDesignation
        
    }
    
    var sectionMassPerMetre: Double {
        
        return _sectionMassPerMetre
        
    }
    
    var depthOfSection: Double {
        
        return _depthOfSection
        
    }
    
    var widthOfSection: Double {
        
        return _widthOfSection
        
    }
    
    var sectionWebThickness: Double {
        
        return _sectionWebThickness
        
    }
    
    var sectionFlangeThickness: Double {
        
        return _sectionFlangeThickness
        
    }
    
    var sectionRootRadius: Double {
        
        return _sectionRootRadius
        
    }
    
    var depthOfSectionBetweenFillets: Double {
        
        return _depthOfSectionBetweenFillets
        
    }
    
    var ratioForLocalWebBuckling: Double {
        
        return _ratioForLocalWebBuckling
        
    }
    
    var ratioForLocalFlangeBuckling: Double {
        
        return _ratioForLocalFlangeBuckling
        
    }
    
    var dimensionForDetailingEndClearance: Int {
        
        return _dimensionForDetailingEndClearance
        
    }
    
    var dimensionForDetailingNotchN: Int {
        
        return _dimensionForDetailingNotchN
        
    }
    
    var dimensionForDetailingNotchn: Int {
        
        return _dimensionForDetailingNotchn
        
    }
    
    var surfaceAreaPerMetre: Double {
        
        return _surfaceAreaPerMetre
        
    }
    
    var surfaceAreaPerTonne: Double {
        
        return _surfaceAreaPerTonne
        
    }
    
    var secondMomentOfAreaMajorAxis: Double {
        
        return _secondMomentOfAreaMajorAxis
        
    }
    
    var secondMomentOfAreaMinorAxis: Double {
        
        return _secondMomentOfAreaMinorAxis
        
    }
    
    var radiusOfGyrationMajorAxis: Double {
        
        return _radiusOfGyrationMajorAxis
        
    }
    
    var radiusOfGyrationMinorAxis: Double {
        
        return _radiusOfGyrationMinorAxis
        
    }
    
    var elasticModulusMajorAxis: Double {
        
        return _elasticModulusMajorAxis
        
    }
    
    var elasticModulusMinorAxis: Double {
        
        return _elasticModulusMinorAxis
        
    }
    
    var plasticModulusMajorAxis: Double {
        
        return _plasticModulusMajorAxis
        
    }
    
    var plasticModulusMinorAxis: Double {
        
        return _plasticModulusMinorAxis
        
    }
    
    var bucklingParameter: Double {
        
        return _bucklingParameter
        
    }
    
    var torsionalIndex: Double {
        
        return _torsionalIndex
        
    }
    
    var wrapingConstant: Double {
        
        return _wrapingConstant
        
    }
    
    var torsionalConstant: Double {
        
        return _torsionalConstant
        
    }
    
    var areaOfSection: Double {
        
        return _areaOfSection
        
    }
    
    init(firstSectionSeriesNumber: Int, secondSectionSeriesNumber: Int, lastSectionSeriesNumber: Int, sectionSerialNumber: String, fullSectionDesignation: String, sectionMassPerMetre: Double, depthOfSection: Double, widthOfSection: Double, sectionWebThickness: Double, sectionFlangeThickness: Double, sectionRootRadius: Double, depthOfSectionBetweenFillets: Double, ratioForLocalWebBuckling: Double, ratioForLocalFlangeBuckling: Double, dimensionForDetailingEndClearance: Int, dimensionForDetailingNotchN: Int, dimensionForDetailingNotchn: Int, surfaceAreaPerMetre: Double, surfaceAreaPerTonne: Double, secondMomentOfAreaMajorAxis: Double, secondMomentOfAreaMinorAxis: Double, radiusOfGyrationMajorAxis: Double, radiusOfGyrationMinorAxis: Double, elasticModulusMajorAxis: Double, elasticModulusMinorAxis: Double, plasticModulusMajorAxis: Double, plasticModulusMinorAxis: Double, bucklingParameter: Double, torsionalIndex: Double, wrapingConstant: Double, torsionalConstant: Double, areaOfSection: Double) {
        
        self._firstSectionSeriesNumber = firstSectionSeriesNumber
        
        self._secondSectionSeriesNumber = secondSectionSeriesNumber
        
        self._lastSectionSeriesNumber = lastSectionSeriesNumber
        
        self._sectionSerialNumber = sectionSerialNumber
        
        self._fullSectionDesignation = fullSectionDesignation
        
        self._sectionMassPerMetre = sectionMassPerMetre
        
        self._depthOfSection = depthOfSection
        
        self._widthOfSection = widthOfSection
        
        self._sectionWebThickness = sectionWebThickness
        
        self._sectionFlangeThickness = sectionFlangeThickness
        
        self._sectionRootRadius = sectionRootRadius
        
        self._depthOfSectionBetweenFillets = depthOfSectionBetweenFillets
        
        self._ratioForLocalWebBuckling = ratioForLocalWebBuckling
        
        self._ratioForLocalFlangeBuckling = ratioForLocalFlangeBuckling
        
        self._dimensionForDetailingEndClearance = dimensionForDetailingEndClearance
        
        self._dimensionForDetailingNotchN = dimensionForDetailingNotchN
        
        self._dimensionForDetailingNotchn = dimensionForDetailingNotchn
        
        self._surfaceAreaPerMetre = surfaceAreaPerMetre
        
        self._surfaceAreaPerTonne = surfaceAreaPerTonne
        
        self._secondMomentOfAreaMajorAxis = secondMomentOfAreaMajorAxis
        
        self._secondMomentOfAreaMinorAxis = secondMomentOfAreaMinorAxis
        
        self._radiusOfGyrationMajorAxis = radiusOfGyrationMajorAxis
        
        self._radiusOfGyrationMinorAxis = radiusOfGyrationMinorAxis
        
        self._elasticModulusMajorAxis = elasticModulusMajorAxis
        
        self._elasticModulusMinorAxis = elasticModulusMinorAxis
        
        self._plasticModulusMajorAxis = plasticModulusMajorAxis
        
        self._plasticModulusMinorAxis = plasticModulusMinorAxis
        
        self._bucklingParameter = bucklingParameter
        
        self._torsionalIndex = torsionalIndex
        
        self._wrapingConstant = wrapingConstant
        
        self._torsionalConstant = torsionalConstant
        
        self._areaOfSection = areaOfSection
        
    }
    
}
