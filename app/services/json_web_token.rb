module JsonWebToken
    SECRET = ENV.fetch('JWT_SECRET') { Rails.application.secret_key_base }
    EXP = 30.days # atur sesuai kebutuhan
    
    
    module_function
    
    
    def encode(payload, exp: EXP.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET, 'HS256')
    end
    
    
    def decode(token)
    body = JWT.decode(token, SECRET, true, { algorithm: 'HS256' }).first
    HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
    end
    end