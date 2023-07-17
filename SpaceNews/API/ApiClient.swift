//
//  ApiClient.swift
//  SpaceNews
//
//  Created by Richard Uzor on 17/07/2023.
//

//API endpoint: https://api.spaceflightnewsapi.net/v3/articles
import Foundation

struct SpaceData: Codable, Identifiable{
    //implementing 'Identifiable' makes it possible for us to acknowledge the id of the fetched data
    var id: Int
    var title: String
    var url: String
    var imageUrl: String
    var newsSite: String
    var summary: String
    var publishedAt: String
}

//class to update the data live in our environment object
//handle retrieving the data
//main actor means this class is updating the ui
@MainActor class SpaceApi: ObservableObject{
 
    @Published var news: [SpaceData] = []
    
    func getData(){
        //assign the api endpoint to the url variable
        guard let url = URL(string: "https://api.spaceflightnewsapi.net/v3/articles?_limit=10")else{
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else{
                //handle error
                let tempError = error!.localizedDescription
                DispatchQueue.main.async {
                    //set the content of the news to have error messages
                    self.news = [SpaceData(id: 0, title: tempError, url: "Error", imageUrl: "Error", newsSite: "Error", summary: "Try swiping down to refresh a soon as you have internet", publishedAt: "Error")]
                }
                return
            }
            //retrieve the json data
            let spaceData = try! JSONDecoder().decode([SpaceData].self, from: data)
            
            //update the ui to print the foollowing message
            DispatchQueue.main.async {
                print("Loaded new data successfully. Articles: \(spaceData.count)")
                //assign the fetched data to the published news variable
                self.news = spaceData
            }
        }.resume()
    }
}
