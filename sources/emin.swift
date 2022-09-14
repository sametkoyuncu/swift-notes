 func fetchData() {
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=464f8a5567ef6de84d256d195532ca13")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            guard let safeData = data else { return}
            do {
                if error == nil {
                    let jsonData =
                    try JSONDecoder().decode(DataModel.self, from: safeData)
                    self.dataModel = jsonData.results
                    DispatchQueue.main.async {
                        self.myTable.reloadData()
                    }
                }
            } catch {
                print("Error")
            }
        }.resume()
        
        
    }
