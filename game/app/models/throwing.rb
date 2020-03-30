class Throwing < ActiveRecord::Base
    def calculate_score()
      turn = 0
      frames = []

      entrada.upcase.split('').each do |char|
        # Toma un turno y si no existe crea uno nuevo
        frame = frames[turn] || { rolls: [] }
        frames[turn] = frame

        last_frame = frames.length == 10

        case char
        when 'X' # Strike
          frame[:rolls] << 10
          frame[:strike] = true
          turn += 1 unless last_frame
        when '/' # Spare
          frame[:rolls] << 10 - frame[:rolls].first
          frame[:spare] = true
          turn += 1 unless last_frame
        when '-' # Miss
          frame[:rolls] << 0

          # pasar al siguiente luego de dos tiros
          if !last_frame && frame[:rolls].length == 2
            turn += 1
          end
        else # number
          frame[:rolls] << char.to_i

          # pasar al siguente frame luego de dos tiros
          if !last_frame && frame[:rolls].length == 2
            turn += 1
          end
        end
      end

      # analizar turnos
      score = 0

      frames.each_with_index do |frame, index|
        if frame[:strike]
          next_frame = frames[index + 1]

          if next_frame
            if next_frame[:rolls].length >= 2
              score += next_frame[:rolls][0...2].sum
            else
              score += next_frame[:rolls].first

              next_next_frame = frames[index + 2]
              score += next_next_frame[:rolls].first if next_next_frame
            end
          end
          
        end

        if frame[:spare]
          next_frame = frames[index + 1]

          if next_frame
            score += next_frame[:rolls].first
          end
        end

        # siempre sumar los tiros del frame
        score += frame[:rolls].sum

      end
      self.score = score

    end
end
