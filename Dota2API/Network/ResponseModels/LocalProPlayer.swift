struct LocalProPlayer {
    let playerImage: String
    let teamLogo: String
    let name: String
    let teamTag: String
    let teamName: String
}

extension LocalProPlayer {
    static let mockData: [LocalProPlayer] = [
        .init(playerImage: "miracle",
              teamLogo: "nigma",
              name: "Miracle-",
              teamTag: "NGX",
              teamName: "Nigma Galaxy"),

        .init(playerImage: "topson",
              teamLogo: "og",
              name: "Topson",
              teamTag: "OG",
              teamName: "OG Esports"),

        
        .init(playerImage: "collapse",
              teamLogo: "spirit",
              name: "Collapse",
              teamTag: "TS",
              teamName: "Team Spirit"),

        .init(playerImage: "ame",
              teamLogo: "xtreme",
              name: "Ame",
              teamTag: "XG",
              teamName: "Xtreme Gaming"),
        
        .init(playerImage: "yatoro",
              teamLogo: "spirit",
              name: "Yatoro",
              teamTag: "TS",
              teamName: "Team Spirit"),

        .init(playerImage: "sumail",
              teamLogo: "nigma",
              name: "SumaiL",
              teamTag: "NGX",
              teamName: "Nigma Galaxy"),

        .init(playerImage: "zai",
              teamLogo: "liquid",
              name: "zai",
              teamTag: "TL",
              teamName: "Team Liquid"),

        .init(playerImage: "matu",
              teamLogo: "liquid",
              name: "MATUMBAMAN",
              teamTag: "TL",
              teamName: "Team Liquid"),

        .init(playerImage: "puppey",
              teamLogo: "secret",
              name: "Puppey",
              teamTag: "Secret",
              teamName: "Team Secret"),

        .init(playerImage: "ceb",
              teamLogo: "og",
              name: "Ceb",
              teamTag: "OG",
              teamName: "OG Esports")
    ]
}
