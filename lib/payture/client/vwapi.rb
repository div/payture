module Payture
  class Client
    module Vwapi

      def register(options={})
        response = get('Register', options)
        response.register
      end

      def add(options={})
        response = get('Add', options)
        response.add
      end

      def pay(options={})
        response = get('Pay', options)
        response.pay
      end

      def get_list(options={})
        response = get('GetList', options)
        response.get_list
      end

      def activate(options={})
        response = get('Activate', options)
        response.activate
      end

      # def user_follows(*args)
      #   options = args.last.is_a?(Hash) ? args.pop : {}
      #   id = args.first || "self"
      #   response = get("users/#{id}/follows", options)
      #   response
      # end
      #
      # def user_followed_by(*args)
      #   options = args.last.is_a?(Hash) ? args.pop : {}
      #   id = args.first || "self"
      #   response = get("users/#{id}/followed-by", options)
      #   response
      # end
      #
      # def user_liked_exchanges(options={})
      #   response = get("users/self/media/liked", options)
      #   response
      # end
      #
      # def user_relationship(id, options={})
      #   response = get("users/#{id}/relationship", options)
      #   response
      # end
      #
      # def follow_user(id, options={})
      #   options["action"] = "follow"
      #   response = post("users/#{id}/relationship", options)
      #   response
      # end
      #
      # def unfollow_user(id, options={})
      #   options["action"] = "unfollow"
      #   response = post("users/#{id}/relationship", options)
      #   response
      # end
    end
  end
end
