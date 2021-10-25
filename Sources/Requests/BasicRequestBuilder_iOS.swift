/*****************************************************************************************************
 * Copyright 2016 SPECURE GmbH
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *****************************************************************************************************/

import Foundation
import UIKit

///
class BasicRequestBuilder: AbstractBasicRequestBuilder {

    ///
    override class func addBasicRequestValues(_ basicRequest: BasicRequest) {
        super.addBasicRequestValues(basicRequest)

        let currentDevice = UIDevice.current

        basicRequest.device = currentDevice.model
        basicRequest.model = UIDeviceHardware.platform()
        basicRequest.osVersion = currentDevice.systemVersion
        basicRequest.plattform = "iOS"
        basicRequest.clientType = "MOBILE"
        
//        basicRequest.previousTestStatus = RMBTSettings.shared.previousTestStatus ?? RMBTTestStatus.None.rawValue
//        basicRequest.softwareRevision = RMBTBuildInfoString()
//        basicRequest.softwareVersion = infoDictionary["CFBundleShortVersionString"] as? String
//        basicRequest.softwareVersionCode = infoDictionary["CFBundleVersion"] as? Int
    }

}
