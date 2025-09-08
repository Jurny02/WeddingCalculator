//
//  WCLogger.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 08/09/2025.
//

import OSLog

func getLogger(category: String) -> Logger {
    Logger(subsystem: "com.bartoszjurczyk.WeddingCalculator", category: category)
}
