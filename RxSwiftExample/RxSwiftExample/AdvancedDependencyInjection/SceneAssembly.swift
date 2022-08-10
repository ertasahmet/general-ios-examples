//
//  SceneAssembly.swift
//  RxSwiftExample
//
//  Created by Ahmet Ertas on 23.06.2022.
//

import Swinject

final class SceneAssembly: Assembly {

    func assemble(container: Container) {
        let assemblies: [Assembly] = [
         /*   SplashAssembly(),
            AccountAssembly(),
            AuthenticationAssembly(),
            ProfileAssembly(),
            SavedMoviesAssembly(),
            CustomListsAssembly(),
            CustomListDetailAssembly(),
            UpcomingMoviesAssembly(),
            MovieDetailAssembly(),
            SearchMoviesAssembly(),
            MovieListAssembly(),
            MovieCreditsAssembly(),
            MovieVideosAssembly(),
            MovieReviewsAssembly(),
            MovieReviewDetailAssembly()*/
        ]
        assemblies.forEach { $0.assemble(container: container) }
    }

}
