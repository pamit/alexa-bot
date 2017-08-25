require 'singleton'

module Alexa
  class Response
    include Singleton
    attr_accessor :reprompt

    def initialize
      @reprompt = "Can I help you with anything else?"
    end

    def make_response(alexa_request, alexa_response)

      if alexa_request.type == "LAUNCH_REQUEST"
        launch_request(alexa_response)
      elsif alexa_request.type == "SESSION_ENDED_REQUEST"
        session_ended(alexa_response)
      elsif alexa_request.type == "AMAZON.CancelIntent"
        session_ended(alexa_response)
      elsif alexa_request.type == "AMAZON.StopIntent"
        session_ended(alexa_response)
      elsif alexa_request.type == "AMAZON.NoIntent"
        session_ended(alexa_response)
      elsif alexa_request.type == "AMAZON.YesIntent"
        help_intent(alexa_response)
      elsif alexa_request.type == "INTENT_REQUEST"
        case alexa_request.name
        when "CompanyInfoIntent"
          company_info(alexa_response)
        when "ProjectsListIntent"
          projects_list(alexa_response)
        when "ProjectInfoIntent"
          project_info(alexa_request, alexa_response)
        when "ContactIntent"
          contact(alexa_response)
        when "UserInfoIntent"
          user_info(alexa_request, alexa_response)
        when "HelpIntent"
          help_intent(alexa_response)
        end
      end

    end

    def launch_request alexa_response
      speech_text =
        "Welcome to Round Table Apps. " +
        "We are a software development company and we can help you with your business. " +
        "You can ask me about our company and our projects."
      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Can I help you with anything else?", true)
      alexa_response.say_response_with_reprompt(speech_text, @reprompt, false)
    end

    def session_ended alexa_response
      alexa_response.add_speech("We hope to see you soon. Goodbye.", true)
    end

    def help_intent alexa_response
      speech_text = ""
      speech_text += "Here are some things you can say: "
      speech_text += "Tell me about Round Table Apps. "
      speech_text += "Tell me about your projects. "
      speech_text += "Give me some information about a project. "
      speech_text += "You can also say stop if you're done. "
      speech_text += "So how can I help?"
      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Can I help you with anything else?", true)
      alexa_response.say_response_with_reprompt(speech_text, @reprompt, false)
    end

    def company_info alexa_response
      data = [
        "We are Round Table Apps. We build the best Apps for Life. We are mobile and website app developers building digital solutions to make life better for your business and better for your customers. Tell us the change you want to create in the world and we will make it happen.",
        "We are Your Tech Partner Our army of experienced mobile developers, web developers, architects, designers and entrepreneurial thinkers are ready to take on your projects and partner with you on the tech side.",
        "Round Table is a full stack web development agency for all of your tech needs. We create beautiful, functional, innovative software that achieves measurable results for your business and that your customers will love to use."
      ]
      speech_text = data[((Random.rand * 1000) % data.size).floor]
      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Can I help you with anything else?", true)
      alexa_response.say_response_with_reprompt(speech_text, @reprompt, false)
    end

    def projects_list alexa_response
      speech_text = "These are some of our projects: my sumo, zupply, pfm, pip mcgregor, hum, workfast"
      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Can I help you with anything else?", true)
      alexa_response.say_response_with_reprompt(speech_text, @reprompt, false)
    end

    def project_info alexa_request, alexa_response
      speech_text = ""
      project = alexa_request.slots["project"]["value"]
      if !project || project.empty?
        speech_text = "Ask me about a project and I can give you more details on that."
      elsif (project == "my sumo")
        speech_text = "With sumo app you can order salads from Sumo Salad stores and you can collect points for your next order."
      elsif (project == "zupply")
        speech_text = "Zupply is a successful B2B ecommerce website which helps businessess to find each other."
      elsif (project == "douugh")
        speech_text = "Personal finance manager for you. It helps you manage your expenses."
      elsif (project == "hum")
        speech_text = "Hum is a B2B website to help businesses manage their requirements."
      elsif (project == "pip mcgregor")
        speech_text = "Pip McGregor helps you with the best optometrists in Sydney."
      end

      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Can I help you with anything else?", true)
      alexa_response.say_response_with_reprompt(speech_text, @reprompt, false)
    end

    def contact alexa_response
      speech_text = "Ok. Would you please tell me your number?"
      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Ok. Would you please tell me your number?", true)
      alexa_response.say_response_with_reprompt(speech_text, "Ok. Would you please tell me your number?", false)
    end

    def user_info alexa_request, alexa_response
      speech_text = "Thank you. We will call you on " + alexa_request.slots["phone"]["value"] + "."
      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Can I help you with anything else?", true)
      alexa_response.say_response_with_reprompt(speech_text, @reprompt, false)
    end
  end
end
