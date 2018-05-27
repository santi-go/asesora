module Actions
    module Mergeable
        def add_with_prefix(base, added, prefix)
            prefixed = prefix(added,prefix)
            add(base,prefixed)
        end
    
        def prefix(base, prefix)
            prefixed = {}
            base.each {|key,value|
              prefixed[prefix+'_'+key] = value
            }
            prefixed
        end
    
        def add(base,added)
          base.merge(added)
        end
    end
end