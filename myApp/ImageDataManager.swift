//
//  ImageDataManager.swift
//  myApp
//
//  Created by AntoineBendafi on 20/11/2023.
//

import Foundation

class ImageDataManager: ObservableObject {
    @Published var images: [ImageData]

    init() {
        self.images = [
            ImageData(url: "https://uploads-ssl.webflow.com/5f3c19f18169b62a0d0bf387/60d33be745999ac3353f49bd_KyhyHs_Rlf3kWWoC8Al_C9Y9SZ4dQu_K0fiLIsiCA5Gl8M3Eq77np68PFUgDPd6lKA8EmhKgWs7joHpsQm8upaoIayr4hi6O7Oj3HTzcoVop1HORjy74OdVTZNqFg_mIlfotr0EJ.png", title: "Image 1", description: "Description 1", author: "Auteur 1", date: Date()),
            ImageData(url: "https://www.freecodecamp.org/news/content/images/2019/07/arrays-are-objects.jpg", title: "Image 2", description: "Description 2", author: "Auteur 2", date: Date()),
            ImageData(url: "https://uploads-ssl.webflow.com/5f3c19f18169b62a0d0bf387/60d33be8cf4ba7565123c8bc_YPD3ulQQAGQpOcnqIm3QzSTRgzmr1SexpW9ZjMpJ1mAnUxx4iF05XOTu44sk0qQG-8XgBcYmGZGAD-5SAZvJl3TjtmhgWnn-w0C2XKwhBscV78RVvhwZfyp0v_Pa6sNj5zxpOvRW.png", title: "Image 3", description: "Description 3", author: "Auteur 3", date: Date()),
            ImageData(url: "https://uploads-ssl.webflow.com/5f3c19f18169b62a0d0bf387/60d33bed9c10a58c67d5e458_g3aUbBRKfdR_6OG1TCTnUbr6646sydM67yBSoKQY1bK3gi4o6eUUkFqUrWc6Sg-ycGJ1zUn3SWhgSfh_A1-F10cvgmKPFM2cae0Vgt500TDqVezLt_-l6fQQYKHda_-kp-0OgW6A.png", title: "Image 4", description: "Description 4", author: "Auteur 4", date: Date())
            // et ainsi de suite
        ]
    }

    func addImage(_ imageData: ImageData) {
        images.append(imageData)
    }
    
    func removeImage(byUrl url: String) {
        images.removeAll { $0.url == url }
    }
    
    func updateImage(_ updatedImageData: ImageData) {
        if let index = images.firstIndex(where: { $0.url == updatedImageData.url }) {
            images[index] = updatedImageData
        }
    }
}




