require 'contentful_middleman'
require 'slim'

activate :livereload

activate :contentful do |f|
  f.space = {blog: 'orzkxlxlq59d'}
  f.access_token = 'b647051b281945536370a7a1295dd1ee9456e1f9114b8849c78734a655f2a577'
  f.all_entries = true
  f.content_types = {posts: 'post'}
  f.cda_query = {content_type: 'post', include: 2, order: '-fields.fechaDePublicacion'}
end

activate :contentful do |f|
  f.space = {navegacion: 'orzkxlxlq59d'}
  f.access_token = 'b647051b281945536370a7a1295dd1ee9456e1f9114b8849c78734a655f2a577'
  f.all_entries = true
  f.content_types = {paginas: 'pagina'}
  f.cda_query = {'include' => 2}
end

if data.key?('blog') && data.blog.key?('posts')
  data.blog.posts.each do |_, post|
    proxy "/posts/#{post.slug}.html", "/posts/post.html", locals: {post: post}, ignore: true
  end
end

if data.key?('navegacion') && data.navegacion.key?('paginas')
  data.navegacion.paginas.each do |_, pagina|
    proxy "/#{pagina.slug}.html", "/paginas/pagina.html", locals: {pagina: pagina}, ignore: true
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

configure :build do
end
