Camping.goes :Blog

module Blog::Controllers
	class Index
		def get
			@posts = Post.all
			render :index
		end
	end
	class PostX
		def get(title)
			@post = Post.find_by_title(title)
			render :post
		end
	end
end

module Blog::Views
	def layout
		html do
			head do
				title { "Blog!" }
			end
			body do
				h1 "THIS BLOG MAN!"
				self << yield
			end
		end
		
	end

	def index
		@posts.each do |po|
			h2 po.title
			p po.content
		end
	end
	def post
		h1 @post.title
		p  @post.content
	end
end

module Blog::Models
	class Post < Base
		validates_presence_of :title
		validates_presence_of :content
	end
	
	class Fields < V 1.0
		def self.up
			create_table Post.table_name do |t|
				t.string :title
				t.text 	:content
				t.timestamps
			end
		end
		
		def self.down
			drop_table Post.table_name
		end
	end
end

#create migrations
def Blog.create
	Blog::Models.create_schema
end
