# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    # Inicia el cilo que evalua todos los items
    @items.each do |item|
      # Exluye a los items Aged y Backstage de disminuir la calidad
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')

        # Evalua que la calidad siempre sea un numero positivo
        if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
          item.quality = if item.name == 'Conjured Mana Cake'
                           item.quality - 2
                         else
                           item.quality - 1
                         end
          # Disminuye la calidad en 1 exceptuando los antes mencionados
          # item.quality = item.quality - 1
        end

      # Modifica los items Age y Backstage
      elsif item.quality < 50
        # Evalua que la calidad siempre este por debajo de 50
        item.quality = item.quality + 1

        # Evalula el item Backstage passes to a TAFKAL80ETC concert
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'

          # Evalua que backstage tenga menos de 11 dias de venta
          if item.sell_in < 11 && (item.quality < 50)

            # Le suma una unidad mas a la calidad dando un total de 2
            item.quality = item.quality + 1
          end

          # Evalua que backstage tenga menos de 6 dias de venta
          if item.sell_in < 6 && (item.quality < 50)

            # Si backstage tiene 5 dias o menos y si su calidad es menor a 50 se le suma uno
            item.quality = item.quality + 1
          end
        end

        # Incrementa la calidad en 1
      end

      # Disminuye el dia de venta en uno a todos los articulos excluyendo
      # el articulo sulfuras
      item.sell_in = item.sell_in - 1 if item.name != 'Sulfuras, Hand of Ragnaros'

      # Degrada la calidad despues de finalizar sus dias de venta
      if item.sell_in.negative?

        # Excluye a Aged porque este item no disminuye su calidad a pesar
        # de ya no contar con dias de venta
        if item.name != 'Aged Brie'

          # Excluye a backstage porque cuando sus dias de venta caen a menos a cero
          # su calidad tambien se reduce a cero
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            puts item.quality if item.name == 'Conjured Mana Cake'

            # Evalua que la calidad del item siempre sea mayor a 0
            if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')

              # Le disminuye la calidad en 2 a conjurado y en 1 al resto de los items
              if item.name == 'Conjured Mana Cake' && item.quality > 1
                puts item.quality
                item.quality = item.quality - 2

              else
                item.quality = item.quality - 1
              end

              # item.quality = item.quality - 1
            end

          # La calidad de backstage se disminye en cero
          else
            item.quality = item.quality - item.quality
          end
        elsif item.quality < 50

          # Evalua que la calidad de Aged no revase los 50, en caso de ser menos a 50
          # aumenta una unidad en su calidad
          item.quality = item.quality + 1
        end
      end
    end
  end
end

