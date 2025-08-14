//
//  BigButton.swift
//  The23MinRule
//
//  Created by Karim Mufti on 8/13/25.
//

import Foundation
import SwiftUI

struct BigButton: View {
    let title: String
    let action: () -> Void
    var filled: Bool = true

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundColor(filled ? .white : .appText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    ZStack {
                        if filled {
                            RoundedRectangle(cornerRadius: 18)
                                .fill(LinearGradient(colors: [.appPrimaryHi, .appPrimary],
                                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                        } else {
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color.appCard)
                        }
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
                .shadow(color: .appPrimary.opacity(filled ? 0.5 : 0), radius: 18, x: 0, y: 10)
        }
    }
}
