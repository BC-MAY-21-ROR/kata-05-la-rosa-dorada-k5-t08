# frozen_string_literal: true

# Esta es la clase de la tienda, en esta calse se hacen todas las condicionales para cada item
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    # Inicia el cilo que evalua todos los items
    @items.each do |item|
      update_quality2(item)
      decrease_day(item)
      update_quality3(item)
    end
  end

  # Disminuye el dia de venta en uno a todos los articulos excluyendo el articulo sulfuras
  def decrease_day(item)
    item.sell_in = item.sell_in - 1 if item.name != 'Sulfuras, Hand of Ragnaros'
  end

  # Evalua la calidad siempre y cuando sus dias de venta sean positivos
  def update_quality2(item)
    if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
      update_quality4(item) if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
    elsif item.quality < 50
      increase_quality(item)
    end
  end

  # evalua la calidad si la calidad de venta es vencida
  def update_quality3(item)
    evaluate_backstage(item) if item.sell_in.negative? && (item.name != 'Aged Brie')
  end

  def evaluate_backstage(item)
    if item.name != 'Backstage passes to a TAFKAL80ETC concert'
      if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
        update_quality4(item)
      else
        item.quality -= item.quality
      end
    elsif item.quality < 50
      item.quality = item.quality + 1
    end
  end

  # Disminuye la calidad del item Conjured en 2 y del resto en 1
  def update_quality4(item)
    item.quality = if item.name == 'Conjured Mana Cake' && item.quality > 1
                     item.quality - 2
                   else
                     item.quality - 1
                   end
  end

  # Evalua la calidad del item backstage dependiendo sus dias para el concierto
  def backstage_quality(item)
    item.quality = item.quality + 1 if item.sell_in < 11 && (item.quality < 50)
    item.quality = item.quality + 1 if item.sell_in < 6 && (item.quality < 50)
  end

  # Incrementa calidad a agend y backstage
  def increase_quality(item)
    item.quality = item.quality + 1
    backstage_quality(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
  end
end
