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
        "Welcome to MY COMPANY. " +
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
      speech_text += "Tell me about MY COMPANY. "
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
        "We are MY COMPANY. We build best apps!",
        "We are a full stack web development agency"
      ]
      speech_text = data[((Random.rand * 1000) % data.size).floor]
      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Can I help you with anything else?", true)
      alexa_response.say_response_with_reprompt(speech_text, @reprompt, false)
    end

    def projects_list alexa_response
      speech_text = "These are some of our projects: AA, BB, CC and DD"
      # alexa_response.add_speech(speech_text, true)
      # alexa_response.add_reprompt("Can I help you with anything else?", true)
      alexa_response.say_response_with_reprompt(speech_text, @reprompt, false)
    end

    def project_info alexa_request, alexa_response
      speech_text = ""
      project = alexa_request.slots["project"]["value"]
      if !project || project.empty?
        speech_text = "Ask me about a project and I can give you more details on that."
      elsif (project == "AA")
        speech_text = "AA is about"
      elsif (project == "BB")
        speech_text = "BB is about"
      elsif (project == "CC")
        speech_text = "CC is about"
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
