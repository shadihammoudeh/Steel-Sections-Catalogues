//
//  IsectionsDimensionsParameters.swift
//  Steel Sections Catalogues
//
//  Created by Shadi Hammoudeh on 27/07/2019.
//  Copyright © 2019 Bespoke Engineering. All rights reserved.
//

import Foundation

class SteelSectionParameters {
    
    // Below are the corresponding steel section parameters that get populated from its relevant parsed CSV file:
    
    var _firstSectionSeriesNumber: Int!
    
    var _secondSectionSeriesNumber: Int!
    
    var _lastSectionSeriesNumber: Double!
    
    var _sectionSerialNumber: String!
    
    var _fullSectionDesignation: String!
    
    var _firstSectionSeriesNumberCrossSectionIsCutFrom: Int!
    
    var _secondSectionSeriesNumberCrossSectionIsCutFrom: Int!
    
    var _thirdSectionSeriesNumberCrossSectionIsCutFrom: Int!
    
    var _sectionSerialNumberCrossSectionIsCutFrom: String!
        
    var _sectionCutFromUniversalBeam: String!
    
    var _sectionCutFromUniversalColumn: String!
    
    var _sectionMassPerMetre: Double!
    
    var _sectionLegLength: Double!
    
    var _sectionTotalDepth: Double!
    
    var _sectionWidth: Double!
    
    var _sectionLegThickness: Double!
    
    var _sectionWebThickness: Double!
    
    var _sectionFlangeThickness: Double!
    
    var _sectionRootRadiusOne: Double!
    
    var _sectionRootRadiusTwo: Double!
    
    var _sectionDepthBetweenFillets: Double!
    
    var _sectionLocalDiameterBucklingRatio: Double!
    
    var _sectionLocalWebBucklingRatio: Double!
    
    var _sectionLocalFlangeBucklingRatio: Double!
    
    var _sectionShearCentreFromWebCentreline: Double!
    
    var _sectionCentreOfGravityXdirection: Double!
    
    var _sectionCentreOfGravityYdirection: Double!
    
    var _sectionEndClearanceDimensionForDetailing: Int!
    
    var _sectionNotchNdimensionForDetailing: Int!
    
    var _sectionNotchnDimensionForDetailing: Int!
    
    var _sectionSurfaceAreaPerMetre: Double!
    
    var _sectionSurfaceAreaPerTonne: Double!
    
    var _sectionMajorSecondMomentOfAreaAboutYYaxis: Double!
    
    var _sectionMinorSecondMomentOfAreaAboutZZaxis: Double!
    
    var _sectionMajorSecondMomentOfAreaAboutUUaxis: Double!
    
    var _sectionMinorSecondMomentOfAreaAboutVVaxis: Double!
    
    var _sectionMajorRadiusOfGyrationAboutYYaxis: Double!
    
    var _sectionMinorRadiusOfGyrationAboutZZaxis: Double!
    
    var _sectionMajorRadiusOfGyrationAboutUUaxis: Double!
    
    var _sectionMinorRadiusOfGyrationAboutVVaxis: Double!
    
    var _sectionMajorElasticModulusAboutYYaxis: Double!
    
    var _sectionMinorElasticModulusAboutZZaxis: Double!
    
    var _sectionMajorFlangeElasticModulusAboutYYaxis: Double!
    
    var _sectionMajorToeElasticModulusAboutYYaxis: Double!
    
    var _sectionMinorToeElasticModulusAboutZZaxis: Double!
    
    var _sectionMajorPlasticModulusAboutYYaxis: Double!
    
    var _sectionMinorPlasticModulusAboutZZaxis: Double!
    
    var _sectionAngleAxisYYtoAxisUUtanAlpha: Double!
    
    var _sectionBucklingParameterU: Double!
    
    var _sectionTorsionalIndexX: Double!
    
    var _sectionWarpingConstantIwInDm6: Double!
    
    var _sectionWarpingConstantIwInCm6: Double!
    
    var _sectionTorsionalConstantIt: Double!
    
    var _sectionTorsionalConstantWt: Double!
    
    var _sectionEquivalentSlendernessCoefficient: Double!
    
    var _sectionMinimumEquivalentSlendernessCoefficient: Double!
    
    var _sectionMaximumEquivalentSlendernessCoefficient: Double!
    
    var _sectionMonoSymmetryIndexPsiA: Double!
    
    var _sectionMonoSymmetryIndexPsi: Double!
    
    var _areaOfSection: Double!
    
    var firstSectionSeriesNumber: Int {
        
        return _firstSectionSeriesNumber
        
    }
    
    var secondSectionSeriesNumber: Int {
        
        return _secondSectionSeriesNumber
        
    }
    
    var lastSectionSeriesNumber: Double {
        
        return _lastSectionSeriesNumber
        
    }
    
    var sectionSerialNumber: String {
        
        return _sectionSerialNumber
        
    }
    
    var fullSectionDesignation: String {
        
        return _fullSectionDesignation
        
    }
    
    var firstSectionSeriesNumberCrossSectionIsCutFrom: Int {
        
        return _firstSectionSeriesNumberCrossSectionIsCutFrom
        
    }
    
    var secondSectionSeriesNumberCrossSectionIsCutFrom: Int {
        
        return _secondSectionSeriesNumberCrossSectionIsCutFrom
        
    }
    
    var thirdSectionSeriesNumberCrossSectionIsCutFrom: Int {
        
        return _thirdSectionSeriesNumberCrossSectionIsCutFrom
        
    }
    
    var sectionSerialNumberCrossSectionIsCutFrom: String {
        
        return _sectionSerialNumberCrossSectionIsCutFrom
        
    }
    
    var sectionCutFromUniversalBeam: String {
        
        return _sectionCutFromUniversalBeam
        
    }
    
    var sectionCutFromUniversalColumn: String {
        
        return _sectionCutFromUniversalColumn
        
    }
    
    var sectionMassPerMetre: Double {
        
        return _sectionMassPerMetre
        
    }
    
    var sectionLegLength: Double {
        
        return _sectionLegLength
        
    }
    
    var sectionTotalDepth: Double {
        
        return _sectionTotalDepth
        
    }
    
    var sectionWidth: Double {
        
        return _sectionWidth
        
    }
    
    var sectionLegThickness: Double {
        
        return _sectionLegThickness
        
    }
    
    var sectionWebThickness: Double {
        
        return _sectionWebThickness
        
    }
    
    var sectionFlangeThickness: Double {
        
        return _sectionFlangeThickness
        
    }
    
    var sectionRootRadiusOne: Double {
        
        return _sectionRootRadiusOne
        
    }
    
    var sectionRootRadiusTwo: Double {
        
        return _sectionRootRadiusTwo
        
    }
    
    var sectionDepthBetweenFillets: Double {
        
        return _sectionDepthBetweenFillets
        
    }
    
    var sectionLocalDiameterBucklingRatio: Double {
        
        return _sectionLocalDiameterBucklingRatio
        
    }
    
    var sectionLocalWebBucklingRatio: Double {
        
        return _sectionLocalWebBucklingRatio
        
    }
    
    var sectionLocalFlangeBucklingRatio: Double {
        
        return _sectionLocalFlangeBucklingRatio
        
    }
    
    var sectionShearCentreFromWebCentreline: Double {
        
        return _sectionShearCentreFromWebCentreline
        
    }
    
    var sectionCentreOfGravityXdirection: Double {
        
        return _sectionCentreOfGravityXdirection
        
    }
    
    var sectionCentreOfGravityYdirection: Double {
        
        return _sectionCentreOfGravityYdirection
        
    }
    
    var sectionEndClearanceDimensionForDetailing: Int {
        
        return _sectionEndClearanceDimensionForDetailing
        
    }
    
    var sectionNotchNdimensionForDetailing: Int {
        
        return _sectionNotchNdimensionForDetailing
        
    }
    
    var sectionNotchnDimensionForDetailing: Int {
        
        return _sectionNotchnDimensionForDetailing
        
    }
    
    var sectionSurfaceAreaPerMetre: Double {
        
        return _sectionSurfaceAreaPerMetre
        
    }
    
    var sectionSurfaceAreaPerTonne: Double {
        
        return _sectionSurfaceAreaPerTonne
        
    }
    
    var sectionMajorSecondMomentOfAreaAboutYYaxis: Double {
        
        return _sectionMajorSecondMomentOfAreaAboutYYaxis
        
    }
    
    var sectionMinorSecondMomentOfAreaAboutZZaxis: Double {
        
        return _sectionMinorSecondMomentOfAreaAboutZZaxis
        
    }
    
    var sectionMajorSecondMomentOfAreaAboutUUaxis: Double {
        
        return _sectionMajorSecondMomentOfAreaAboutUUaxis
    }
    
    var sectionMinorSecondMomentOfAreaAboutVVaxis: Double {
        
        return _sectionMinorSecondMomentOfAreaAboutVVaxis
        
    }
    
    var sectionMajorRadiusOfGyrationAboutYYaxis: Double {
        
        return _sectionMajorRadiusOfGyrationAboutYYaxis
        
    }
    
    var sectionMinorRadiusOfGyrationAboutZZaxis: Double {
        
        return _sectionMinorRadiusOfGyrationAboutZZaxis
        
    }
    
    var sectionMajorRadiusOfGyrationAboutUUaxis: Double {
        
        return _sectionMajorRadiusOfGyrationAboutUUaxis
        
    }
    
    var sectionMinorRadiusOfGyrationAboutVVaxis: Double {
        
        return _sectionMinorRadiusOfGyrationAboutVVaxis
        
    }
    
    var sectionMajorElasticModulusAboutYYaxis: Double {
        
        return _sectionMajorElasticModulusAboutYYaxis
        
    }
    
    var sectionMinorElasticModulusAboutZZaxis: Double {
        
        return _sectionMinorElasticModulusAboutZZaxis
        
    }
    
    var sectionMajorFlangeElasticModulusAboutYYaxis: Double {
        
        return _sectionMajorFlangeElasticModulusAboutYYaxis
        
    }
    
    var sectionMajorToeElasticModulusAboutYYaxis: Double {
        
        return _sectionMajorToeElasticModulusAboutYYaxis
        
    }
    
    var sectionMinorToeElasticModulusAboutZZaxis: Double {
        
        return _sectionMinorToeElasticModulusAboutZZaxis
        
    }
    
    var sectionMajorPlasticModulusAboutYYaxis: Double {
        
        return _sectionMajorPlasticModulusAboutYYaxis
        
    }
    
    var sectionMinorPlasticModulusAboutZZaxis: Double {
        
        return _sectionMinorPlasticModulusAboutZZaxis
        
    }
    
    var sectionAngleAxisYYtoAxisUUtanAlpha: Double {
        
        return _sectionAngleAxisYYtoAxisUUtanAlpha
        
    }
    
    var sectionBucklingParameterU: Double {
        
        return _sectionBucklingParameterU
        
    }
    
    var sectionTorsionalIndexX: Double {
        
        return _sectionTorsionalIndexX
        
    }
    
    var sectionWarpingConstantIwInDm6: Double {
        
        return _sectionWarpingConstantIwInDm6
        
    }
    
    var sectionWarpingConstantIwInCm6: Double {
        
        return _sectionWarpingConstantIwInCm6
        
    }
    
    var sectionTorsionalConstantIt: Double {
        
        return _sectionTorsionalConstantIt
        
    }
    
    var sectionTorsionalConstantWt: Double {
        
        return _sectionTorsionalConstantWt
        
    }
    
    var sectionEquivalentSlendernessCoefficient: Double {
        
        return _sectionEquivalentSlendernessCoefficient
        
    }
    
    var sectionMinimumEquivalentSlendernessCoefficient: Double {
        
        return _sectionMinimumEquivalentSlendernessCoefficient
        
    }
    
    var sectionMaximumEquivalentSlendernessCoefficient: Double {
        
        return _sectionMaximumEquivalentSlendernessCoefficient
        
    }
    
    var sectionMonoSymmetryIndexPsiA: Double {
        
        return _sectionMonoSymmetryIndexPsiA
        
    }
    
    var sectionMonoSymmetryIndexPsi: Double {
        
        return _sectionMonoSymmetryIndexPsi
        
    }
    
    var sectionArea: Double {
        
        return _areaOfSection
        
    }
    
    init(firstSectionSeriesNumber: Int, secondSectionSeriesNumber: Int, lastSectionSeriesNumber: Double, sectionSerialNumber: String, fullSectionDesignation: String, firstSectionSerialNumberCrossSectionIsCutFrom: Int, secondSectionSerialNumberCrossSectionIsCutFrom: Int, thirdSectionSerialNumberCrossSectionIsCutFrom: Int, sectionSerialNumberCrossSectionIsCutFrom: String,sectionCutFromUniversalBeam: String, sectionCutFromUniversalColumn: String, sectionMassPerMetre: Double, sectionLegLength: Double, sectionTotalDepth: Double, sectionWidth: Double, sectionLegThickness: Double, sectionWebThickness: Double, sectionFlangeThickness: Double, sectionRootRadiusOne: Double, sectionRootRadiusTwo: Double, sectionDepthBetweenFillets: Double, sectionLocalDiameterBucklingRatio: Double, sectionLocalWebBucklingRatio: Double, sectionLocalFlangeBucklingRatio: Double, sectionShearCentreFromWebCentreline: Double, sectionCentreOfGravityXdirection: Double, sectionCentreOfGravityYdirection: Double, sectionEndClearanceDimensionForDetailing: Int, sectionNotchNdimensionForDetailing: Int, sectionNotchnDimensionForDetailing: Int, sectionSurfaceAreaPerMetre: Double, sectionSurfaceAreaPerTonne: Double, sectionMajorSecondMomentOfAreaAboutYYaxis: Double, sectionMinorSecondMomentOfAreaAboutZZaxis: Double, sectionMajorSecondMomentOfAreaAboutUUaxis: Double, sectionMinorSecondMomentOfAreaAboutVVaxis: Double, sectionMajorRadiusOfGyrationAboutYYaxis: Double, sectionMinorRadiusOfGyrationAboutZZaxis: Double, sectionMajorRadiusOfGyrationAboutUUaxis: Double, sectionMinorRadiusOfGyrationAboutVVaxis: Double, sectionMajorElasticModulusAboutYYaxis: Double, sectionMinorElasticModulusAboutZZaxis: Double, sectionMajorFlangeElasticModulusAboutYYaxis: Double, sectionMajorToeElasticModulusAboutYYaxis: Double, sectionMinorToeElasticModulusAboutZZaxis: Double, sectionMajorPlasticModulusAboutYYaxis: Double, sectionMinorPlasticModulusAboutZZaxis: Double, sectionAngleAxisYYtoAxisUUtanAlpha: Double, sectionBucklingParameterU: Double, sectionTorsionalIndexX:Double, sectionWarpingConstantIwInDm6: Double, sectionWarpingConstantIwInCm6: Double, sectionTorsionalConstantIt: Double, sectionTorsionalConstantWt: Double, sectionEquivalentSlendernessCoefficient: Double, sectionMinimumEquivalentSlendernessCoefficient: Double, sectionMaximumEquivalentSlendernessCoefficient: Double, sectionMonoSymmetryIndexPsiA: Double, sectionMonoSymmetryIndexPsi: Double, sectionArea: Double) {
        
        self._firstSectionSeriesNumber = firstSectionSeriesNumber
        
        self._secondSectionSeriesNumber = secondSectionSeriesNumber
        
        self._lastSectionSeriesNumber = lastSectionSeriesNumber
        
        self._sectionSerialNumber = sectionSerialNumber
        
        self._fullSectionDesignation = fullSectionDesignation
        
        self._firstSectionSeriesNumberCrossSectionIsCutFrom = firstSectionSerialNumberCrossSectionIsCutFrom
        
        self._secondSectionSeriesNumberCrossSectionIsCutFrom = secondSectionSerialNumberCrossSectionIsCutFrom
        
        self._thirdSectionSeriesNumberCrossSectionIsCutFrom = thirdSectionSerialNumberCrossSectionIsCutFrom
        
        self._sectionSerialNumberCrossSectionIsCutFrom = sectionSerialNumberCrossSectionIsCutFrom
        
        self._sectionCutFromUniversalBeam = sectionCutFromUniversalBeam
        
        self._sectionCutFromUniversalColumn = sectionCutFromUniversalColumn
        
        self._sectionMassPerMetre = sectionMassPerMetre
        
        self._sectionLegLength = sectionLegLength
        
        self._sectionTotalDepth = sectionTotalDepth
        
        self._sectionWidth = sectionWidth
        
        self._sectionLegThickness = sectionLegThickness
        
        self._sectionWebThickness = sectionWebThickness
        
        self._sectionFlangeThickness = sectionFlangeThickness
        
        self._sectionRootRadiusOne = sectionRootRadiusOne
        
        self._sectionRootRadiusTwo = sectionRootRadiusTwo
        
        self._sectionDepthBetweenFillets = sectionDepthBetweenFillets
        
        self._sectionLocalDiameterBucklingRatio = sectionLocalDiameterBucklingRatio
        
        self._sectionLocalWebBucklingRatio = sectionLocalWebBucklingRatio
        
        self._sectionLocalFlangeBucklingRatio = sectionLocalFlangeBucklingRatio
        
        self._sectionShearCentreFromWebCentreline = sectionShearCentreFromWebCentreline
                
        self._sectionCentreOfGravityXdirection = sectionCentreOfGravityXdirection
        
        self._sectionCentreOfGravityYdirection = sectionCentreOfGravityYdirection
        
        self._sectionEndClearanceDimensionForDetailing = sectionEndClearanceDimensionForDetailing
        
        self._sectionNotchNdimensionForDetailing = sectionNotchNdimensionForDetailing
        
        self._sectionNotchnDimensionForDetailing = sectionNotchnDimensionForDetailing
        
        self._sectionSurfaceAreaPerMetre = sectionSurfaceAreaPerMetre
        
        self._sectionSurfaceAreaPerTonne = sectionSurfaceAreaPerTonne
        
        self._sectionMajorSecondMomentOfAreaAboutYYaxis = sectionMajorSecondMomentOfAreaAboutYYaxis
        
        self._sectionMinorSecondMomentOfAreaAboutZZaxis = sectionMinorSecondMomentOfAreaAboutZZaxis
        
        self._sectionMajorSecondMomentOfAreaAboutUUaxis = sectionMajorSecondMomentOfAreaAboutUUaxis
        
        self._sectionMinorSecondMomentOfAreaAboutVVaxis = sectionMinorSecondMomentOfAreaAboutVVaxis
        
        self._sectionMajorRadiusOfGyrationAboutYYaxis = sectionMajorRadiusOfGyrationAboutYYaxis
        
        self._sectionMinorRadiusOfGyrationAboutZZaxis = sectionMinorRadiusOfGyrationAboutZZaxis
        
        self._sectionMajorRadiusOfGyrationAboutUUaxis = sectionMajorRadiusOfGyrationAboutUUaxis
        
        self._sectionMinorRadiusOfGyrationAboutVVaxis = sectionMinorRadiusOfGyrationAboutVVaxis
        
        self._sectionMajorElasticModulusAboutYYaxis = sectionMajorElasticModulusAboutYYaxis
        
        self._sectionMinorElasticModulusAboutZZaxis = sectionMinorElasticModulusAboutZZaxis
        
        self._sectionMajorFlangeElasticModulusAboutYYaxis = sectionMajorFlangeElasticModulusAboutYYaxis
        
        self._sectionMajorToeElasticModulusAboutYYaxis = sectionMajorToeElasticModulusAboutYYaxis
        
        self._sectionMinorToeElasticModulusAboutZZaxis = sectionMinorToeElasticModulusAboutZZaxis
        
        self._sectionMajorPlasticModulusAboutYYaxis = sectionMajorPlasticModulusAboutYYaxis
        
        self._sectionMinorPlasticModulusAboutZZaxis = sectionMinorPlasticModulusAboutZZaxis
        
        self._sectionAngleAxisYYtoAxisUUtanAlpha = sectionAngleAxisYYtoAxisUUtanAlpha
        
        self._sectionBucklingParameterU = sectionBucklingParameterU
        
        self._sectionTorsionalIndexX = sectionTorsionalIndexX
        
        self._sectionWarpingConstantIwInDm6 = sectionWarpingConstantIwInDm6
        
        self._sectionWarpingConstantIwInCm6 = sectionWarpingConstantIwInCm6
        
        self._sectionTorsionalConstantIt = sectionTorsionalConstantIt
        
        self._sectionTorsionalConstantWt = sectionTorsionalConstantWt
        
        self._sectionEquivalentSlendernessCoefficient = sectionEquivalentSlendernessCoefficient
        
        self._sectionMinimumEquivalentSlendernessCoefficient = sectionMinimumEquivalentSlendernessCoefficient
        
        self._sectionMaximumEquivalentSlendernessCoefficient = sectionMaximumEquivalentSlendernessCoefficient
        
        self._sectionMonoSymmetryIndexPsiA = sectionMonoSymmetryIndexPsiA
        
        self._sectionMonoSymmetryIndexPsi = sectionMonoSymmetryIndexPsi
        
        self._areaOfSection = sectionArea
        
    }
    
}
