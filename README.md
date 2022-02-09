**Objetivo**

Utilizando a API do The Movie DB, implementar uma tela com as informações de um filme qualquer.

**API**

**Endpoints do Desafio:**

- Details: https://developers.themoviedb.org/3/movies/get-movie-details
- Similar: https://developers.themoviedb.org/3/movies/get-similar-movies
- Genre: https://developers.themoviedb.org/3/genres/get-movie-list
- Images: https://developers.themoviedb.org/3/getting-started/images

**Endpoints Bônus:**

- Now Playing: https://developers.themoviedb.org/3/movies/get-now-playing
- Popular: https://developers.themoviedb.org/3/movies/get-popular-movies
- Top Rated: https://developers.themoviedb.org/3/movies/get-top-rated-movies
- Search: https://developers.themoviedb.org/3/search/search-movies


**Layout do Desafio**

Layout da tela de detalhe dos filmes do app TodoMovies4 (tela: https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/97/0e/e2/970ee217-13cf-1674-b016-461aca657663/pr_source.png/460x0w.png).

**Layout Bônus**

- Criado uma Tab Bar para navegação entres as telas dos endpoints bônus citados acima.
- Na primeira aba exibe uma tela com todos os filmes em cartaz em forma de GRID.
- Na segunda aba é exibido os filmes mais populares com um layout retangular, distruibindo os filmes verticalmente.
- Na terceira aba foi implementado os filmes mais votados, com três elementos, uma foto em forma circular, um título e uma descrição do filme.
- Na quarta aba o usuário pode realizar uma pesquisa do seu filme favorito e o resultado retornará uma tela com o layout semelhante da terceira tela(Top Rated).
- A tela detalhes é basicamente a mesma tela pedida no desafio, porém tem um efeito na imagem quando é arrasta para cima ou para baixo.

Ambas as telas permitem ao usuário clicar/tocar no filme e ser encaminhado para a **tela de detalhes do filme**.

**Requisitos Utilizados:**

- Design Pattern: MVC.
- Endpoint getMovieDetails.
- Utilizado o vote_count que retorna da API para representar o número de likes.
- O ícone de like (coração) deve mudar quando clicado, alternando entre preenchido e vazio.
- Lista de filmes abaixo dos detalhes.
- Desenvolvido utilizando a linguagem Swift.

**Bibliotecas de Terceiros Utilizadas:**
- Alamofire
- Kingfisher

Pod install:

- pod 'Alamofire', '~> 4.0'
Base: https://cocoapods.org/pods/Alamofire
- pod 'Kingfisher', '~> 4.0'
Base: https://cocoapods.org/pods/Kingfisher
