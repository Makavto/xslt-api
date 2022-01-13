# Контроллер, который делает всю работу в этом приложении
class XmlController < ApplicationController
    before_action :parse_params, only: :index
    def index
      result = calculate(@v1)
      data = if result.nil?
               { message: "Неверные параметры запроса (массив = #{@v1})" }
             else
               result
             end

  
      respond_to do |format|
        format.xml { render xml: result.to_xml }
        format.rss { render xml: result.to_xml }
      end
    end
  
    protected

    def parse_params
      @v1 = params[:v1].to_s
    end
  
    private

    def calculate(massive)
        kol = 0;
      
        def stepen(x)
            a = 1
            while a<=x
                a = a * 5
                if a == x then
                    return true
                end
            end 
            return false;
        end
      
        segment = Array[];
        # segmentsHash = Hash.new => {};
        segmentsHash = {};
        j = 1;
        max = Array[];
        if !(massive.is_a?(String))
            return nil
        end
        mas = massive.split(/[, ;]/).map(&:to_i)
        mas.each_index do |i|
            if (mas[i+1]!=nil && stepen(mas[i]) && stepen(mas[i+1]))
                segment.push(mas[i])
            elsif (mas[i-1]!=nil && stepen(mas[i]) && stepen(mas[i-1]))
                segment.push(mas[i])
            end
            if ((mas[i+1]!=nil && !stepen(mas[i+1]) && !segment.empty?) || (mas[i+1] == nil && !segment.empty?))
                segmentsHash["iterate#{j}"] = segment;
                j = j+1;
                kol = kol+1;
                if (segment.length > max.length)
                    max = segment
                end
                segment = []
            end
        end
        if (kol>0)
          result = [massive, segmentsHash, kol, max]
        else
          result = 0
        end
        return result
    end
end

