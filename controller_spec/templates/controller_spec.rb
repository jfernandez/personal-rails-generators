require 'spec_helper'

describe <%= plural_class_name %>Controller do

  describe "GET #index" do
    it "renders the index template" do
      get :index
      response.should render_template("index")
    end

    it "queries <%= class_name %>.all" do
      <%= class_name %>.should_receive(:all)
      get :index
    end

    it "assigns @<%= plural_name %>" do
      get :index
      assigns[:<%= plural_name %>].should_not be_nil
    end
  end
  
  describe "GET #show" do
    before(:each) do
      @<%= singular_name %> = stub_model(<%= class_name %>)
      <%= class_name %>.stub!(:find).and_return(@<%= singular_name %>)
    end
    
    it "renders the show template" do
      get :show, :id => @<%= singular_name %>.id
      response.should render_template("show")
    end
    
    it "finds the <%= human_name %>" do
      <%= class_name %>.should_receive(:find).with(@<%= singular_name %>.id.to_s)
      get :show, :id => @<%= singular_name %>.id
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      response.should render_template("new")
    end

    it "assigns a new @<%= singular_name %>" do
      get :new
      assigns[:<%= singular_name %>].should_not be_nil
      assigns[:<%= singular_name %>].new_record?.should == true
    end
  end
  
  describe "POST #create" do
    before(:each) do
      @<%= singular_name %> = stub_model(<%= class_name %>)
      <%= class_name %>.stub!(:new).and_return(@<%= singular_name %>)
    end

    it "creates a new <%= human_name %>" do
      <%= class_name %>.should_receive(:new).with("attr" => "val")
      post :create, :<%= singular_name %> => { "attr" => "val" }
    end

    it "saves the <%= human_name %>" do
      @<%= singular_name %>.should_receive(:save)
      post :create
    end

    context "when the <%= human_name %> saves successfully" do
      before(:each) do
        @<%= singular_name %>.stub!(:save).and_return(true)
      end

      it "sets a flash[:success] message" do
        post :create
        flash[:success].should == "The <%= human_name %> was saved successfully."
      end

      it "redirects to <%= plural_name %>_url" do
        post :create
        response.should redirect_to(<%= plural_name %>_url)
      end
    end

    context "when the <%= human_name %> fails to save" do
      before(:each) do
        @<%= singular_name %>.stub!(:save).and_return(false)
      end

      it "assigns @<%= singular_name %>" do
        post :create
        assigns[:<%= singular_name %>].should == @<%= singular_name %>
      end

      it "renders the new template" do
        post :create
        response.should render_template("new")
      end
    end
  end
  
  describe "GET #edit" do
    before(:each) do
      @<%= singular_name %> = stub_model(<%= class_name %>)
      <%= class_name %>.stub!(:find).and_return(@<%= singular_name %>)
    end
    
    it "renders the new template" do
      get :edit, :id => @<%= singular_name %>.id
      response.should render_template("edit")
    end
    
    it "finds the <%= human_name %>" do
      <%= class_name %>.should_receive(:find).with(@<%= singular_name %>.id.to_s)
      get :edit, :id => @<%= singular_name %>.id
    end
  end
  
  describe "PUT #update" do
    before(:each) do
      @<%= singular_name %> = stub_model(<%= class_name %>)
      <%= class_name %>.stub!(:find).and_return(@<%= singular_name %>)
    end

    it "finds the <%= human_name %>" do
      <%= class_name %>.should_receive(:find).with(@<%= singular_name %>.id.to_s)
      put :update, :id => @<%= singular_name %>.id
    end
    
    it "assigns @<%= singular_name %>" do
      put :update, :id => @<%= singular_name %>.id
      assigns[:<%= singular_name %>].should == @<%= singular_name %>
    end

    it "saves the <%= human_name %>" do
      @<%= singular_name %>.should_receive(:update_attributes).with("attr" => "val")
      put :update, :id => @<%= singular_name %>.id, :<%= singular_name %> => { "attr" => "val" }
    end

    context "when the <%= human_name %> saves successfully" do
      before(:each) do
        @<%= singular_name %>.stub!(:update_attributes).and_return(true)
      end

      it "sets a flash[:success] message" do
        put :update, :id => @<%= singular_name %>.id
        flash[:success].should == "The <%= human_name %> was saved successfully."
      end

      it "redirects to <%= plural_name %>_url" do
        put :update, :id => @<%= singular_name %>.id
        response.should redirect_to(<%= plural_name %>_url)
      end
    end

    context "when the <%= human_name %> fails to save" do
      before(:each) do
        @<%= singular_name %>.stub!(:update_attributes).and_return(false)
      end

      it "renders the edit template" do
        put :update, :id => @<%= singular_name %>.id
        response.should render_template("edit")
      end
    end
  end
end