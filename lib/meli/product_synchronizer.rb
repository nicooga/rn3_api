class Meli::ProductSynchronizer
  class << self
    def perform
      item_ids = Meli::Client.instance.get_my_item_ids.fetch(:results)
      item_ids.each do |item_id|
        item = Meli::Client.instance.get_item(item_id)
        sync_item(item)
      end
    end

    private

    def sync_item(item)
      product =
        Product.find_by(meli_id: item.id) ||
        Product.find_by(meli_id: item.parent_item_id) ||
        Product.new

      if item.status == 'closed' && product.persisted?
        product.destroy!
      else
        product.assign_attributes(
          meli_id:   item.id,
          permalink: item.permalink,
          pictures:  item.pictures.map(&:url),
          title:     item.title
        )

        product.save!
      end
    end
  end
end
