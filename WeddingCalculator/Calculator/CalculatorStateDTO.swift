import Foundation

struct CalculatorStateDTO: Codable {
    let date: Date
    let currentSavings: Double
    let currentSavingsEUR: Double
    let groomMonthly: Double
    let brideMonthly: Double

    init(from calculatorSate: CalculatorState) {
        self.date = calculatorSate.weddingDate
        self.currentSavings = calculatorSate.currentSavings
        self.currentSavingsEUR = calculatorSate.currentSavingsEUR
        self.groomMonthly = calculatorSate.groomMonthly
        self.brideMonthly = calculatorSate.brideMonthly
    }
}
