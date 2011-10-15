Camping.goes :Blog

module Blog::Controllers
	class Index
		def get
			@posts = Post.all
			render :index
		end
	end
	class Post < R '/(\d+)'
		
	end
end

module Blog::Views
	def index
		@posts.each do |po|
			h2 po.title
			p po.content
	end
	def post
		
	end
end

module Blog::Models
	class Post < Base
	end
	
	
end
