Swagger::Docs::Config.register_apis({
  "1.0" => {
    # the extension used for the API
    :api_extension_type => :json,
    # the output location where your .json files are written to
    :api_file_path => "public/swagger_docs",
    # the URL base path to your API
    :base_path => "#{ENV['REGISTRY_HOSTNAME']}",
    # if you want to delete all .json files at each generation
    :base_api_controller => "Api::ApiController",
    :clean_directory => true,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "DigitalGov Registry",
        "description" => "This registry serves as a central source of Government sponsored social media and mobile applicaitons.",
        "termsOfServiceUrl" => "http://registry.digitalgov.gov",
        "contact" => "registry@digitalgov.gov",
        "license" => "MIT License",
        "licenseUrl" => "http://opensource.org/licenses/MIT"
      }
    }
  }
})