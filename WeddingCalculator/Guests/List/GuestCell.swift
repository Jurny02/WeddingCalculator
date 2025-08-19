//
//  GuestCell.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 16/08/2025.
//

import SwiftUI

struct GuestCell: View {
    let guest: GuestModel
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(guest.name)
                    .font(.headline)
                Text("\(guest.numberOfGuests) guest\(guest.numberOfGuests > 1 ? "s" : "") • \(guest.country)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if guest.confirmed {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.green)
            } else {
                Image(systemName: "xmark.seal.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        
    }
}

#Preview {
    VStack {
        GuestCell(guest: .init(name: "Bartosz Jurczyk", confirmed: true, numberOfGuests: 4, country: "Polska"))
        GuestCell(guest: .init(name: "Bartosz Jurczyk", confirmed: false, numberOfGuests: 3, country: "Polska"))
    }
}
