//
//  ChipNavigationView.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//
import SwiftUI

struct ChipNavigationView: View {
    @State private var selectedChip: String = "All"
    @ObservedObject var vm = NewsViewModelImpl(service: NewsServiceImpl())
    
    let chipOptions = ["All", "Business", "Sports", "Weather", "More"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 8)  {
                ForEach(chipOptions, id: \.self) { chip in
                    Button(action: {
                        selectedChip = chip
                    }) {
                        
                        HStack(alignment: .center, spacing: 8) {
                            Text(chip)
                              .font(
                                Font.custom("Nunito", size: 12)
                                  .weight(.semibold)
                              )
                              .foregroundColor(selectedChip == chip ? .white : .primary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedChip == chip ?
                          LinearGradient(
                            stops: [
                              Gradient.Stop(color: Color(red: 1, green: 0.23, blue: 0.27), location: 0.00),
                              Gradient.Stop(color: Color(red: 1, green: 0.5, blue: 0.53), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0, y: 0),
                            endPoint: UnitPoint(x: 1.07, y: 1.65)
                          ):
                               
                                        LinearGradient(
                                            stops: [
                                                Gradient.Stop(color: Color.white, location: 0.00), // Add a white stop at the beginning
                                                
                                            ],
                                            startPoint: UnitPoint(x: 0, y: 0),
                                            endPoint: UnitPoint(x: 1.07, y: 1.65)
                                        )

                        )
                        .cornerRadius(16)
                        .overlay(selectedChip == chip ?
                          RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(red: 1, green: 0.7, blue: 0.72), lineWidth: 1) :
                                    
                                    RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 0.94, green: 0.94, blue: 0.98), lineWidth: 1)

                                    
                                    
                        )
                        
//                        Text(chip)
//                            .foregroundColor(selectedChip == chip ? .white : .primary)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 6)
//                            .background(selectedChip == chip ? Color.red : Color(.systemGray6))
//
//                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal, 16)
            
     
        }
    }
}

struct ChipNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ChipNavigationView()
    }
}
