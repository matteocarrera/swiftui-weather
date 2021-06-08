//
//  CountryListView.swift
//  Weather
//
//  Created by Владимир Макаров on 02.06.2021.
//

import SwiftUI

private let countryName = "Russia"

struct CountryListView: View {
    
    @Binding public var cities: [String]
    @Environment(\.presentationMode) private var presentationMode
    @State private var cityList = [String]()
    @State private var selectedCity: String?
    @State private var showingAlert = false
    private let countriesClient = CountriesClientImpl()
    
    var body: some View {
        List(cityList, id: \.self, selection: $selectedCity) { city in
            Text(city)
        }
        .listStyle(InsetGroupedListStyle())
        .environment(\.editMode, .constant(EditMode.active))
        .navigationTitle("Cities in \(countryName)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    if selectedCity == nil {
                        showingAlert = true
                        return
                    }
                    cities.append(selectedCity!)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            getCitiesByCountry(countryName: countryName)
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Error"),
                message: Text("City is not selected"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func getCitiesByCountry(countryName: String) {
        countriesClient.getCountryCities(countryName: countryName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(var cities):
                    cities.removeAll(where: { self.cities.contains($0) })
                    self.cityList = cities
                    self.cityList.sort()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView(cities: .constant([String]()))
            .previewDevice("iPhone 11")
    }
}
