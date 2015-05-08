module FunHome
  class Player
    class << self
      def speak(text, args = {})
        language = args[:language]
        voice = args[:voice]
        if voice
          unless osx_speech(voice, text)
            raise("No available voice found, please check if you have downloaded voice [#{voice}] in System Preferences -> Speech")
          end
        else
          list_of_available_voices = `say -v '?'`.split("\n")
          voices = list_of_available_voices.inject({}) do |collection, record|
            matched_results = record.match(/^(.*[^\s])\s+([a-z]{2})[_-][a-zA-Z]{2,}\s+/)
            available_language = matched_results[2].downcase.intern
            available_voice = matched_results[1]
            if collection.has_key?(available_language)
              collection[available_language] << available_voice
            else
              collection[available_language] = [available_voice]
            end
            collection
          end
          osx_speech(voices[language.intern].first, text)
        end
      end
      
      def osx_speech(voice, text)
        system("say -v #{voice} #{text} > /dev/null 2>&1")
      end
    end
    
    private_class_method :osx_speech
  end
end