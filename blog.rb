Camping.goes :Blog

module Blog::Controllers
	class Index
		def get
			if Post.all.empty?
				render :noposts
			else
				@posts = Post.all.sort_by{ |p| p.created_at }.reverse
				render :index
			end
		end
	end
	class PostX
		def get(title)
			@post = Post.find_by_title(title)
			render :post
		end
	end

	class New
		def get
			render :newform
		end

		def post
			Post.create(:title => @input.title, :content => @input.content)
			redirect Index
		end
	end

	class RemoveN
		def get(id)
			@post = Post.find(id)
			render :sure
		end
		def post
			Post.delete
			redirect Index
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
			h2 do
				a po.title, :href => R(PostX, po.title)
			end
			p po.content
		end
	end

	def noposts
		h2 do
			a "No posts found, create new post?", :href => R(New)
		end
	end
	def post
		h1 @post.title
		p  @post.content
		br

		a "Delete post", :href => R(Remove, @post.id)
	end

	def newform
		form :action => R(New), :method => :post do
			p "Title:"
			input :type => :text, :name => :title
			p "Content:"
			textarea "", :name => :content, :rows => 30, :cols => 50

			br

			input :type => :submit, :value => :Submit!
		end
	end

	def sure
		h1 "Are you sure?"
		form :action => R(Remove), :method => :post do
			input :type => :submit, :value => :Yes!
		end
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
