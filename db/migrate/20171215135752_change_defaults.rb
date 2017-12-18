class ChangeDefaults < ActiveRecord::Migration[5.1]
  def change
  
  	# Changing default values of certain fields


  	# Customers
  	change_column_default :customers, :enabled, true

  	# Producers
  	change_column_default :producers, :enabled, true

  	# Products
  	change_column_default :products, :deleted, false
  	change_column_default :products, :enabled, true
  	
  end
end
